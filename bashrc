#!/bin/bash -eu
#
# A simple bashrc
#
# Deliberately simple in order to enable easier hacking
#
# Some of the functions, eg _exit, are intended as an example of a feature of bash
# rather than being inherently useful by themselves.
#
# Contributions welcome


# Use the dotfiles prompt if it exists
if [ -f $HOME/dotfiles/promptrc ]; then
    . $HOME/dotfiles/promptrc
fi

# Use the dotfiles vimrc if one doesn't exist already
if [ ! -f $HOME/.vimrc ]; then
    ln -s $HOME/dotfiles/vimrc $HOME/.vimrc
fi


set -o noclobber
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s histappend

# if there is a DIR_COLORS file then use it
if [ -f /etc/DIR_COLORS ]; then
    eval "$(dircolors -b /etc/DIR_COLORS)"
fi

HOSTFILE=$HOME/.hosts
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

Black='\e[0;30m'    
Red='\e[0;31m'      
Green='\e[0;32m'    
Yellow='\e[0;33m'   
Blue='\e[0;34m'     
Purple='\e[0;35m'   
Cyan='\e[0;36m'     
Magenta='\e[0;35m'  
White='\e[0;37m'    

# Bold
BBlack='\e[1;30m'   
BRed='\e[1;31m'     
BGreen='\e[1;32m'   
BYellow='\e[1;33m'  
BBlue='\e[1;34m'    
BPurple='\e[1;35m'  
BCyan='\e[1;36m'    
BMagenta='\e[1;35m' 
BWhite='\e[1;37m'   

# Background
On_Black='\e[40m' 
On_Red='\e[41m'   
On_Green='\e[42m' 
On_Yellow='\e[43m'
On_Blue='\e[44m'  
On_Purple='\e[45m'
On_Cyan='\e[46m'  
On_White='\e[47m' 

NC='\e[0m'

export EDITOR=vim

## Begin functions

function cd
{
    builtin cd "$@" && ls
}

function cat
{
    $(which cat) "$@" 2>/dev/null
}

function _exit
{
    echo -e "${BRed}Hasta la vista, baby${NC}"
}
trap _exit EXIT

function exists
{
    command -v "$1" >/dev/null 2>&1
}

function xtitle()
{
    case "$TERM" in
    *term* | rxvt)
        echo -en  "\e]0;$*\a" ;;
    *)  ;;
    esac
}

# https://stackoverflow.com/questions/55339579/how-to-add-the-man-command-to-git-bash-on-windows-and-include-the-manuals
function man
{
    for i ; do
        xtitle The $(basename $1|tr -d .[:digit:]) manual
        command man -a "$i"
    done
}


function ii
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}


## Begin Aliases

alias dotfiles="cd $HOME/dotfiles"
alias b="$EDITOR $HOME/dotfiles/bashrc && source $HOME/.bashrc"
alias bprompt="$EDITOR $HOME/dotfiles/promptrc && . $HOME/.bashrc"
alias v="$EDITOR $HOME/.vimrc"

if exists subl; then
    alias s="subl"
fi

alias dev="cd $HOMEDRIVE/dev"
alias h='history'
alias j='jobs -l'

alias ls="ls -h"
alias ll="ls -lhv"

alias grep="grep --color=auto"

alias gc="git checkout"
alias gs="git status"
alias gpull="git pull --rebase --prune"
alias gp="git push"
alias gd="git diff"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gca="git commit --all"
alias gb="git branch -a"


