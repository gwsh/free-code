#!/usr/bin/env bash
# gwsh code - macOS / Linux Installer
set -euo pipefail

PRODUCT="gwsh code"
VERSION="1.0.0"
INSTALL_DIR="/usr/local/lib/gwsh-code"
BIN_LINK="/usr/local/bin/gclaude"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

info()  { echo -e "${CYAN}==> ${NC}$1"; }
ok()    { echo -e "${GREEN}==> ${NC}$1"; }
err()   { echo -e "${RED}==> ${NC}$1" >&2; }
warn()  { echo -e "${YELLOW}==> ${NC}$1"; }

require_root() {
  if [ "$(id -u)" -ne 0 ]; then
    err "This operation requires sudo. Re-run with: sudo $0 $*"
    exit 1
  fi
}

check_git() {
  if command -v git &>/dev/null; then
    info "Git found: $(git --version)"
  else
    warn "Git not found. Some features (diff, commits) may not work."
    warn "Install Git: https://git-scm.com/downloads"
  fi
}

install() {
  require_root

  echo ""
  echo -e "${GREEN}  ╔══════════════════════════════════════╗${NC}"
  echo -e "${GREEN}  ║     GWSH Claude Code ${VERSION}          ║${NC}"
  echo -e "${GREEN}  ║   Free, open-source AI coding CLI    ║${NC}"
  echo -e "${GREEN}  ╚══════════════════════════════════════╝${NC}"
  echo ""

  check_git

  info "Installing to ${INSTALL_DIR}..."
  mkdir -p "$INSTALL_DIR"

  if [ ! -f "$SCRIPT_DIR/gclaude" ]; then
    err "Binary 'gclaude' not found in $SCRIPT_DIR"
    err "Build it first: bun run ./scripts/build.ts --dev --feature-set=dev-full --outname=gclaude"
    exit 1
  fi

  cp "$SCRIPT_DIR/gclaude" "$INSTALL_DIR/gclaude"
  chmod 755 "$INSTALL_DIR/gclaude"

  ln -sf "$INSTALL_DIR/gclaude" "$BIN_LINK"

  ok "Installation complete!"
  echo ""
  ok "Run 'gclaude' to start."
  ok "First time? Use 'gclaude /login' for OAuth, or set ANTHROPIC_API_KEY."
  echo ""
}

uninstall() {
  require_root

  info "Uninstalling ${PRODUCT}..."

  [ -f "$INSTALL_DIR/gclaude" ] && rm -f "$INSTALL_DIR/gclaude"
  [ -d "$INSTALL_DIR" ] && rmdir "$INSTALL_DIR" 2>/dev/null || true
  [ -L "$BIN_LINK" ] && rm -f "$BIN_LINK"

  ok "${PRODUCT} uninstalled successfully."
}

print_usage() {
  cat <<EOF
${PRODUCT} ${VERSION}

Usage: $0 [command]

Commands:
  install     Install ${PRODUCT} (default)
  uninstall   Remove ${PRODUCT}
  help        Show this message

Quick start:
  sudo ./macos-install.sh
  gclaude /login
EOF
}

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

case "${1:-install}" in
  install)    install ;;
  uninstall)  uninstall ;;
  help|--help|-h) print_usage ;;
  *)          print_usage; exit 1 ;;
esac
