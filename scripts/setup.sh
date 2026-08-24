#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
agents_dir="${HOME}/.agents/skills"
claude_dir="${HOME}/.claude/skills"
target_mode=both
action=install
dry_run=false

usage() {
  printf '%s\n' \
    'Usage: scripts/setup.sh [options]' \
    '' \
    '  --agents-only       Link only ~/.agents/skills (Codex and OpenCode)' \
    '  --claude-only       Link only ~/.claude/skills' \
    '  --agents-dir PATH   Override the agents target (useful for tests)' \
    '  --claude-dir PATH   Override the Claude target (useful for tests)' \
    '  --dry-run           Print changes without making them' \
    '  --verify            Check links without making changes' \
    '  --remove            Remove links created from this repository' \
    '  --help              Show this help'
}

while (($#)); do
  case "$1" in
    --agents-only)
      [[ "$target_mode" != claude ]] || { printf '%s\n' 'Cannot combine --agents-only and --claude-only.' >&2; exit 2; }
      target_mode=agents
      ;;
    --claude-only)
      [[ "$target_mode" != agents ]] || { printf '%s\n' 'Cannot combine --agents-only and --claude-only.' >&2; exit 2; }
      target_mode=claude
      ;;
    --agents-dir|--claude-dir)
      (($# >= 2)) || { printf 'Missing path for %s\n' "$1" >&2; exit 2; }
      if [[ "$1" == --agents-dir ]]; then agents_dir=$2; else claude_dir=$2; fi
      shift
      ;;
    --dry-run) dry_run=true ;;
    --verify)
      [[ "$action" == install ]] || { printf '%s\n' 'Choose only one of --verify and --remove.' >&2; exit 2; }
      action=verify
      ;;
    --remove)
      [[ "$action" == install ]] || { printf '%s\n' 'Choose only one of --verify and --remove.' >&2; exit 2; }
      action=remove
      ;;
    --help) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

skills=()
for skill_file in "$repo_dir"/*/SKILL.md; do
  [[ -f "$skill_file" ]] || continue
  skills+=("$(basename "$(dirname "$skill_file")")")
done

retired=(audit-codebase codebase-design improve index-knowledge)
failures=0

remove_owned_link() {
  local link=$1 expected=$2
  if [[ -L "$link" && "$(readlink "$link")" == "$expected" ]]; then
    if [[ "$dry_run" == true ]]; then
      printf 'Would remove %s\n' "$link"
    else
      unlink "$link"
      printf 'Removed %s\n' "$link"
    fi
  fi
}

process_target() {
  local target=$1 skill source link old

  if [[ "$action" == install && ! -d "$target" ]]; then
    if [[ "$dry_run" == true ]]; then
      printf 'Would create %s\n' "$target"
    else
      mkdir -p "$target"
    fi
  fi

  for skill in "${skills[@]}"; do
    source="$repo_dir/$skill"
    link="$target/$skill"

    case "$action" in
      install)
        if [[ -L "$link" && "$(readlink "$link")" == "$source" ]]; then
          continue
        elif [[ -e "$link" || -L "$link" ]]; then
          printf 'Refusing to replace unrelated path: %s\n' "$link" >&2
          failures=$((failures + 1))
        elif [[ "$dry_run" == true ]]; then
          printf 'Would link %s -> %s\n' "$link" "$source"
        else
          ln -s "$source" "$link"
          printf 'Linked %s -> %s\n' "$link" "$source"
        fi
        ;;
      verify)
        if [[ ! -L "$link" || "$(readlink "$link" 2>/dev/null || true)" != "$source" ]]; then
          printf 'Missing or incorrect link: %s\n' "$link" >&2
          failures=$((failures + 1))
        fi
        ;;
      remove) remove_owned_link "$link" "$source" ;;
    esac
  done

  for old in "${retired[@]}"; do
    link="$target/$old"
    source="$repo_dir/$old"
    if [[ "$action" == verify && -L "$link" && "$(readlink "$link")" == "$source" ]]; then
      printf 'Retired repository link remains: %s\n' "$link" >&2
      failures=$((failures + 1))
    elif [[ "$action" != verify ]]; then
      remove_owned_link "$link" "$source"
    fi
  done
}

if [[ "$target_mode" == both || "$target_mode" == agents ]]; then process_target "$agents_dir"; fi
if [[ "$target_mode" == both || "$target_mode" == claude ]]; then process_target "$claude_dir"; fi

if ((failures)); then
  printf 'Finished with %d conflict(s).\n' "$failures" >&2
  exit 1
fi

printf '%s complete.\n' "$action"
