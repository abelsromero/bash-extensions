### GIT completion (or sudo pacman -S git bash-completion)
if [[ -d "${__MY_TOOLS_PATH}/git" ]]; then
  # Shell extensions
  source ${__MY_TOOLS_PATH}/git/git-completion.bash
  source ${__MY_TOOLS_PATH}/git/git-prompt.sh  
else
  function __git_help_install () {
    local git_help_path="${__MY_TOOLS_PATH}/git"
    rm -rf ${git_help_path}
    mkdir -p ${git_help_path}
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -np -P ${git_help_path}
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -np -P ${git_help_path}
  }
fi

PS1='[\e[91m\u\e[32m@\h \W\e[39m]\e[96m$(__git_ps1)\e[39m\n$ '
