#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
agents_source="$repo_dir/globals/AGENTS.md"
claude_source="$repo_dir/globals/CLAUDE.md"
codex_file="${HOME}/.codex/AGENTS.md"
claude_file="${HOME}/.claude/CLAUDE.md"
opencode_file="${XDG_CONFIG_HOME:-${HOME}/.config}/opencode/AGENTS.md"
action=install
dry_run=false

usage() {
  printf '%s\n' \
    'Usage: scripts/setup-globals.sh [options]' \
    '' \
    'Link the shared global instructions for Codex, Claude Code, and OpenCode.' \
    'Existing files and unrelated links are never replaced.' \
    '' \
    '  --codex-file PATH     Override the Codex global instruction file' \
    '  --claude-file PATH    Override the Claude global instruction file' \
    '  --opencode-file PATH  Override the OpenCode global instruction file' \
    '  --dry-run             Print changes without making them' \
    '  --verify              Check the links without making changes' \
    '  --remove              Remove links created by this script' \
    '  --help                Show this help'
}

while (($#)); do
  case "$1" in
    --codex-file|--claude-file|--opencode-file)
      (($# >= 2)) || { printf 'Missing path for %s\n' "$1" >&2; exit 2; }
      case "$1" in
        --codex-file) codex_file=$2 ;;
        --claude-file) claude_file=$2 ;;
        --opencode-file) opencode_file=$2 ;;
      esac
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

failures=0

process_link() {
  local source=$1 link=$2

  case "$action" in
    install)
      if [[ -L "$link" && "$(readlink "$link")" == "$source" ]]; then
        return
      elif [[ -e "$link" || -L "$link" ]]; then
        printf 'Refusing to replace unrelated path: %s\n' "$link" >&2
        failures=$((failures + 1))
      elif [[ "$dry_run" == true ]]; then
        printf 'Would link %s -> %s\n' "$link" "$source"
      else
        mkdir -p "$(dirname "$link")"
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
    remove)
      if [[ -L "$link" && "$(readlink "$link")" == "$source" ]]; then
        if [[ "$dry_run" == true ]]; then
          printf 'Would remove %s\n' "$link"
        else
          unlink "$link"
          printf 'Removed %s\n' "$link"
        fi
      fi
      ;;
  esac
}

process_link "$agents_source" "$codex_file"
process_link "$claude_source" "$claude_file"
process_link "$agents_source" "$opencode_file"

if ((failures)); then
  printf 'Finished with %d conflict(s).\n' "$failures" >&2
  exit 1
fi

printf '%s complete.\n' "$action"
