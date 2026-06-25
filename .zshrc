# --- Silence Powerlevel10k instant prompt warning (MUST BE FIRST) ---
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# --- Powerlevel10k instant prompt preamble (keep at the very top) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Pyenv initialization ---
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# --- Oh My Zsh setup ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh

# --- Additional Pyenv and PATH configuration (optional, if needed) ---
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PATH=/usr/local/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# --- Conda initialize (managed by 'conda init') ---
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/bashaar/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/bashaar/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/bashaar/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/bashaar/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# --- Powerlevel10k main theme init ---
source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Mamba initialize (managed by mamba shell init) ---
export MAMBA_EXE='/opt/homebrew/bin/mamba'
export MAMBA_ROOT_PREFIX='/Users/bashaar/miniforge3'
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# --- EMSDK environment: MUST BE LAST, to avoid prompt issues/warnings ---
export EMSDK_QUIET=1
source ~/Documents/emsdk/emsdk_env.sh
