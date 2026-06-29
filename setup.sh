#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "${BLUE}🚀 Setting up dev environment...${NC}"

# ─── Homebrew ───────────────────────────────────
if ! command -v brew &>/dev/null; then
    echo "${GREEN}📦 Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ─── Packages ───────────────────────────────────
echo "${GREEN}📦 Installing packages...${NC}"
brew install tmux neovim git fzf ripgrep bat exa htop tree wget node 2>/dev/null || true

# ─── Oh My Zsh ──────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "${GREEN}💻 Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ─── Symlink Helper ─────────────────────────────
link_dotfile() {
    local src="$1"
    local dest="$2"
    
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        mkdir -p "$BACKUP"
        mv "$dest" "$BACKUP/"
        echo "  ${YELLOW}📁 Backed up $dest${NC}"
    fi
    
    ln -sf "$src" "$dest"
    echo "  ✅ Linked $dest"
}

# ─── Create Symlinks ────────────────────────────
echo "${GREEN}🔗 Creating symlinks...${NC}"

# Vim
mkdir -p "$HOME/.vim"
link_dotfile "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
link_dotfile "$DOTFILES/vim/autoload" "$HOME/.vim/autoload"
link_dotfile "$DOTFILES/vim/plugged" "$HOME/.vim/plugged"

# Tmux
mkdir -p "$HOME/.tmux"
link_dotfile "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_dotfile "$DOTFILES/tmux/plugins" "$HOME/.tmux/plugins"
link_dotfile "$DOTFILES/tmux/catppuccino" "$HOME/.tmux/catppuccino"
link_dotfile "$DOTFILES/tmux/dracula" "$HOME/.tmux/dracula"

# Zsh
link_dotfile "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link_dotfile "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# Git
if [ -f "$DOTFILES/git/.gitconfig" ]; then
    link_dotfile "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
fi

# ─── Install Vim Plugins ────────────────────────
if command -v vim &>/dev/null; then
    echo "${GREEN}🔌 Installing vim plugins...${NC}"
    vim +PlugInstall +qall 2>/dev/null || true
fi

# ─── Powerlevel10k ──────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "${GREEN}🎨 Installing powerlevel10k...${NC}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" 2>/dev/null || true
fi

echo ""
echo "${BLUE}✨ All done!${NC}"
echo "${YELLOW}📁 Old configs backed up to: $BACKUP${NC}"
echo ""
echo "${GREEN}Next steps:${NC}"
echo "  1. Restart terminal or run: source ~/.zshrc"
echo "  2. In tmux, press prefix + I to install tmux plugins"
echo "  3. Run 'p10k configure' to setup powerlevel10k theme"
