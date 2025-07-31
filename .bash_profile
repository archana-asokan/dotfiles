# BEGIN ANSIBLE MANAGED BLOCK
if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi
# END ANSIBLE MANAGED BLOCK
export BASH_SILENCE_DEPRECATION_WARNING=1

## BEGIN PERSONAL CONFIGS
alias cls=clear

# Random
#export GREP_OPTIONS="-R --no-filename"
# colored grep
#alias grepr='grep --color=always'
#export GREP_COLOR='1;33'
export BLOCKSIZE=1k
export EDITOR=vim

export MANPAGER="less -X"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export CLICOLOR=1
# colored ls
export LSCOLORS='Gxfxcxdxdxegedabagacad'

# History
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="&:ls:mutt:[bf]g:exit:clear:fetchmail *:fetchmail"
export HISTFILESIZE=1000000
export HISTSIZE=1000000
# Less Alias
alias lessr='less -R'

# ls
# List directory contents
alias ls='ls -G'        # Compact view, show colors
alias lsah='ls -lah'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'

# Reload
alias reload='source ~/.bash_profile'

# Quit
alias q='exit'

#Clear
alias c='clear'
alias cls='clear'
#====== Theme ====

if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
elif [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 7)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput dim)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1 | cut -c 1-17) != "nothing to commit" ]] && echo "*"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

parser_in_screen() {
if [ -n "$STY" ]; then echo "(screen)";fi
}

function prompt_command() {
  if [[ "$OSTYPE" == darwin* ]]; then export MOD_HOSTNAME="localbox"; else export MOD_HOSTNAME=$HOSTNAME; fi;
  export PS1='\[${BOLD}${MAGENTA}\]$USER \[$WHITE\]at \[$ORANGE\]$MOD_HOSTNAME \[$WHITE\]in \[$GREEN\] $PWD \[$WHITE\]$([[ -n $(git branch 2> /dev/null) ]] && echo on )\[$PURPLE\] $(parse_git_branch)\[$WHITE\]\[$RESET\]\n$ '
}

python -c 'import sys; print sys.real_prefix' >> /dev/null 2>&1 && export INVENV=1 || export INVENV=0 && prompt_command > /dev/null 2>&1

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
   userStyle="${red}";
else
   userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
   hostStyle="${bold}${red}";
else
   hostStyle="${yellow}";
fi;

## END PERSONAL CONFIGS
