
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.bash_prompt

### GIT autocomplete
if [ -f ~/.git-completion.bash ]; then
        . ~/.git-completion.bash
        # http://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases#15009611
        __git_complete gco _git_checkout
fi

# :( no CORS.
alias chrome_cors="open -a Google\ Chrome --args --disable-web-security --user-data-dir=/tmp"
# open -a Google\ Chrome\ Canary --args --disable-web-security --user-data-dir=$HOME/path/to/some/folder
alias g="git"
alias gd="git diff"
alias gs='git status'
alias gb='git branch -a'
alias grpo='git remote prune origin'
alias gco='git checkout'

### ALL THE OPTIONS. Pretty LS output.
alias ls='ls -GFhl'

#export PATH=/usr/local:$PATH

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# copy+paste from .bashrc
export NVM_DIR="/Users/matthew/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
