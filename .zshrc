export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias -g pp="pnpm"
alias opr="gh pr view --web"
alias grc="git add -A; git rebase --continue"
alias "PP"="git push --force-with-lease"
alias p="git push"
alias a="git add ."
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
    git commit -m "fixup!"
    git push 
}
export PATH="$PATH"
