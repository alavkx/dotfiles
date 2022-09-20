export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias -g pp="pnpm"
alias opr="gh pr view --web"
alias grc="git add -A; git rebase --continue"
alias "pP"="git push --force-with-lease"
alias p="git push"
alias a="git add ."
alias "aa"="git add -A"
alias rr="git reset head~1"
alias oops="git reset head~1"
alias dmr=$DISPENSE_MONOREPO_PATH
alias D=$DISPENSE_MONOREPO_PATH
cC() {
    git add -A
    git commit --amend --no-edit
    git push --force-with-lease
}
cc() {
    git add -A
    git commit -m "fixup!"
    git push 
}
eval "$(op completion zsh)"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export DISPENSE_MONOREPO_PATH="$HOME/dispenseapp/dispense"
