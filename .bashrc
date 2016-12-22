# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

# @TODO add these to git alias. Then make a git import for .bash_profile and move all the git stuff into that
# http://wesbos.com/git-hot-tips/

# @TODO make a .credentials config that contains keys to all services logged into. for example:
# developer.mediamath.com
# conoverm
# mmpassword


# a little note about storing git credentials
# https://help.github.com/articles/caching-your-github-password-in-git/
# see if git credential-osxkeychain is install:
# git credential-osxkeychain
#
# use it "global" for git on mac:
# git config --global credential.helper osxkeychain
# 
# erase credentials: 
# either open keychain access > github.com > delete "internet password"
# or:
# git credential-osxkeychain erase
# host=github.com
# protocol=https

# boot2docker after
# boot2docker -v init
# boot2docker -v up
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/mconover/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

source ~/.git-completion.sh
source ~/.bash_prompt

#export PATH="$(brew --prefix)/bin:$PATH"
export PATH="$(brew --prefix)/sbin:$PATH"


# Adama login. Paste return session into session_id query param

function adama_login() {
# adama_login SERVER_NAME (t1qa1, t1qa2, t1qa3) 
# ?api_base=https%3A%2F%2Ft1qa2.mediamath.com%2Fapi%2Fv2.0%2F&session_id=[copy and paste to here]
# $1 = server you want to log in to

if [  -z "$1" ]
then 
	SERVER="t1qa2"
else
	SERVER=$1
fi  

echo "username: " >&2
read USER
echo "password: " >&2
read -s PASSW

echo "logging in via $SERVER"
/usr/bin/curl "https://${SERVER}.mediamath.com/api/v2.0/login" -d "user=${USER}&password=${PASSW}&api_key=[api key]"

}

# python pi-tools
# alias venv="virtualenv"
# alias activate=". ./venv/bin/activate"

alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# git shortcuts
alias gb="git branch -vva"
alias ga="git add"
alias gd="git diff"
alias gs="git status"

alias al="adama_login"

# sys shortcuts
alias ls="ls -GFlh"
alias chrome="open -a Google\ Chrome"
alias chrome_cors="open -a 'Google Chrome.app' --args --disable-web-security --allow-running-insecure-content --new-window --user-data-dir=/tmp"

alias mm="cd ~/mediamath"
alias vg="cd ~/mediamath/t1apps_dev_php_env/"
alias pint="cd ~/mediamath/pint/"
alias compass="cd ~/mediamath/compass/"
#alias bulkedit='mm; cd compass/src/js/modules/campaign/bulkedit'

# PINT shortcuts
alias dev="ssh ewr-cs-n2.mediamath.com -p 722"
alias pi-deploy="ssh ewr-cs-n2.mediamath.com -p 722"

# chrome disable-web-security freakout
# https://gist.github.com/codeshrew/9260777
# open -a 'Google Chrome.app' --args --disable-web-security --allow-running-insecure-content --new-window --user-data-dir=/tmp

#easylistening
#source /Users/lmoulds/workspace/hackathon/easylistening.sh
source /Users/mconover/.easylistening.sh
alias vagrant=play_music

# brew formulae completion
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${blue}${s}";
	else
		return;
	fi;
}

# if tput setaf 1 &> /dev/null; then
# 	tput sgr0; # reset colors
# 	bold=$(tput bold);
# 	reset=$(tput sgr0);
# 	# Solarized colors, taken from http://git.io/solarized-colors.
# 	black=$(tput setaf 0);
# 	blue=$(tput setaf 33);
# 	cyan=$(tput setaf 37);
# 	green=$(tput setaf 64);
# 	orange=$(tput setaf 166);
# 	purple=$(tput setaf 125);
# 	red=$(tput setaf 124);
# 	violet=$(tput setaf 61);
# 	white=$(tput setaf 15);
# 	yellow=$(tput setaf 136);
# else
# 	bold='';
# 	reset="\e[0m";
# 	black="\e[1;30m";
# 	blue="\e[1;34m";
# 	cyan="\e[1;36m";
# 	green="\e[1;32m";
# 	orange="\e[1;33m";
# 	purple="\e[1;35m";
# 	red="\e[1;31m";
# 	violet="\e[1;35m";
# 	white="\e[1;37m";
# 	yellow="\e[1;33m";
# fi;
#
# # Highlight the user name when logged in as root.
# if [[ "${USER}" == "root" ]]; then
# 	userStyle="${red}";
# else
# 	userStyle="${orange}";
# fi;
#
# # Highlight the hostname when connected via SSH.
# if [[ "${SSH_TTY}" ]]; then
# 	hostStyle="${bold}${red}";
# else
# 	hostStyle="${yellow}";
# fi;
#
# # Set the terminal title to the current working directory.
# PS1="\[\033]0;\w\007\]";
# PS1+="\[${bold}\]\n"; # newline
# PS1+="\[${userStyle}\]\u"; # username
# PS1+="\[${white}\] at ";
# PS1+="\[${hostStyle}\]\h"; # host
# PS1+="\[${white}\] in ";
# PS1+="\[${green}\]\w"; # working directory
# PS1+="\$(prompt_git \"${white} on ${violet}\")"; # Git repository details
# PS1+="\n";
# PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
# export PS1;
#
# PS2="\[${yellow}\]→ \[${reset}\]";
# export PS2;




export NVM_DIR="/Users/mconover/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
