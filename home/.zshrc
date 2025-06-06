export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias -g pp="pnpm"
alias opr="gh pr view --web"
alias ocm="gh browse -n | sed 's/$/\/commit\/'"$(git rev-parse HEAD)"'/' | xargs open"
alias grc="git add -A; git rebase --continue"
alias grp='( 
  if git rev-parse --git-dir >/dev/null 2>&1; then
    RMD=$(git rev-parse --git-path "rebase-merge/")
    if [[ -d "$RMD" && -f "${RMD}msgnum" && -f "${RMD}end" ]]; then
      N=$(cat "${RMD}msgnum")
      L=$(cat "${RMD}end")
      echo "${N} / ${L}"
    else
      echo "Not currently in a rebase"
    fi
  else
    echo "Not in a git repository"
  fi
)'
alias "PP"="git push --force-with-lease"
alias p="git push"
alias a="git add -A"
alias "aa"="git add -A"
alias rr="git reset head~1"
alias oops="git reset head~1"
CC() {
    git add -A
    git commit --amend --no-edit
    git push --force-with-lease
}
cc() {
    git add -A
    git commit --allow-empty-message -n
    git push --no-verify
}
. "$HOME/.local/bin/env"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH="$HOME/Library/Application Support/fnm:$PATH"
eval "$(fnm env --use-on-cd)"
export PNPM_HOME="/Users/alavoie/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# COUPLING WARNING: This .env logic couples user shell config to dotfiles tool
# In production, this would be handled by tool-managed shell hooks
# See ARCHITECTURE.md for cleaner separation approach
if [[ ! -f ~/.env ]]; then
  echo "EXAMPLE_VAR=\"example_value\"" > ~/.env
fi
set -o allexport
source ~/.env
set +o allexport
