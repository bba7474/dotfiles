#!/bin/zsh -eu
#
# A simple .zshrc for use in Z-shell environments
# Recommended use is to append this block to your ~/.bashrc file so you can
# keep this directory under version control:
#
# if [ -f $HOME/dotfiles/zshrc ]; then
#     . $HOME/dotfiles/zshrc
# fi
#
# Deliberately simple in order to enable easier hacking
#
# Some of the functions, eg _exit, are intended as an example of a feature of zsh
# rather than being inherently useful by themselves.
#
# Contributions welcome

# Commented out sections are bits that are taken from my bashrc file that I have not yet ported and tested in zsh

# TODO THIS DOESN'T REALLY WORK IN ZSH
# Use the dotfiles prompt if it exists
# if [ -f $HOME/dotfiles/promptrc ]; then
#    . $HOME/dotfiles/promptrc
# fi

# TODO THIS DOESN'T REALLY WORK IN ZSH
# Use the dotfiles vimrc if one doesn't exist already
# if [ ! -f $HOME/.vimrc ]; then
#    ln -s $HOME/dotfiles/vimrc $HOME/.vimrc
# fi

set -o noclobber
# setopt -s cdspell
# setopt -s cdable_vars
# setopt -s checkhash
# setopt -s checkwinsize
# setopt -s histappend

# HOSTFILE=$HOME/.hosts
# HISTCONTROL=ignoreboth
# HISTSIZE=10000
# HISTFILESIZE=20000
# HISTCONTROL=ignoreboth

# Black='\e[0;30m'
# Red='\e[0;31m'
# Green='\e[0;32m'
# Yellow='\e[0;33m'
# Blue='\e[0;34m'
# Purple='\e[0;35m'
# Cyan='\e[0;36m'
# Magenta='\e[0;35m'
# White='\e[0;37m'

# # Bold
# BBlack='\e[1;30m'
# BRed='\e[1;31m'
# BGreen='\e[1;32m'
# BYellow='\e[1;33m'
# BBlue='\e[1;34m'
# BPurple='\e[1;35m'
# BCyan='\e[1;36m'
# BMagenta='\e[1;35m'
# BWhite='\e[1;37m'

# # Background
# On_Black='\e[40m'
# On_Red='\e[41m'
# On_Green='\e[42m'
# On_Yellow='\e[43m'
# On_Blue='\e[44m'
# On_Purple='\e[45m'
# On_Cyan='\e[46m'
# On_White='\e[47m'

# NC='\e[0m'

export EDITOR=vim
export CLICOLOR=YES

## Begin functions

function cd
{
    builtin cd "$@" && ls
}

# function cat
# {
#     $(which cat) "$@" 2>/dev/null
# }

# function _exit
# {
#     echo -e "${BRed}Hasta la vista, baby${NC}"
# }
# trap _exit EXIT

function exists
{
    command -v "$1" >/dev/null 2>&1
}

# function xtitle()
# {
#     case "$TERM" in
#     *term* | rxvt)
#         echo -en  "\e]0;$*\a" ;;
#     *)  ;;
#     esac
# }

# # https://stackoverflow.com/questions/55339579/how-to-add-the-man-command-to-git-bash-on-windows-and-include-the-manuals
# function man
# {
#     for i ; do
#         xtitle The $(basename $1|tr -d .[:digit:]) manual
#         command man -a "$i"
#     done
# }


# function ii
# {
#     echo -e "\nYou are logged on ${BRed}$HOST"
#     echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
#     echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
#              cut -d " " -f1 | sort | uniq
#     echo -e "\n${BRed}Current date :$NC " ; date
#     echo -e "\n${BRed}Machine stats :$NC " ; uptime
#     echo -e "\n${BRed}Memory stats :$NC " ; free
#     echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
#     echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
#     echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
#     echo
# }

# function gp
# {
#     unset PUSH_AND_SET_UPSTREAM_CMD
#     unset PUSH_OUTPUT
#     unset PULL_REQUEST_URL

#     PUSH_OUTPUT="$(git push "$@" 2>&1 | tee /dev/tty)"

#     if [[ "$PUSH_OUTPUT" == *"no upstream branch"* ]]; then
#         PUSH_AND_SET_UPSTREAM_CMD=$(git push "$@" 2>&1 | tail -n2)
#         echo "Upstream not set... setting with '$(echo $PUSH_AND_SET_UPSTREAM_CMD)'"
#         PUSH_OUTPUT="$($PUSH_AND_SET_UPSTREAM_CMD 2>&1 >/dev/null)"
#     fi

#     which chrome >/dev/null 2>&1

#     if [ "$?" -eq 0 ]; then
#         PULL_REQUEST_URL=$(echo "$PUSH_OUTPUT" | grep -o "remote: .*" | sed -ur 's/remote:(.*)/\1/' | tail -2)

#         if [ "$PULL_REQUEST_URL" != "" ]; then
#             echo "Loading Pull Request in your favourite browser... (CTRL+C to cancel)"
#             sleep 1
#             chrome $PULL_REQUEST_URL
#         fi
#     fi
# }

# ## Begin Aliases

alias dotfiles="cd $HOME/git/dotfiles"
alias z="$EDITOR $HOME/git/dotfiles/bashrc && source $HOME/.bashrc"
# alias bprompt="$EDITOR $HOME/dotfiles/promptrc && . $HOME/.bashrc"
alias v="$EDITOR $HOME/.vimrc"

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

alias h='history'
alias j='jobs -l'

alias ls="ls -h"
alias ll="ls -lhv"

alias gc="git checkout"
alias gs="git status"
alias gpull="git pull --rebase --prune"
alias gpp="gpull && gp"
alias gd="git diff"
alias gdd="git diff --color-words"
alias gl="git log -n 10 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gca="git commit --all"
alias gb="git branch -a"
alias grm="git fetch && git rebase origin/master"
alias gaac="git add --all && git commit -m"
alias master="git fetch && git checkout master && git rebase origin/master"

alias sshh="ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR -o UserKnownHostsFile=/dev/null"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
