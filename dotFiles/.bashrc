##COMMENTS######################################################################
# ~/.bashrc
#
# If not running interactively, don't do anything

##OPENING SCREEN GEMS###########################################################
[[ $- != *i* ]] && return
a=`echo $(( (RANDOM % 4 ) +1))`
if [ $a = "1" ] ;
then
	cmatrix -s
elif [ $a = "2" ] ;
then
	fortune | cowsay
elif [ $a = "3" ] ;
then
	archey3
else [ $a = "4" ] ;
	asciiquarium
fi

##EXPORTS#######################################################################
export PATH="/usr/lib/ccache/bin/:/home/rassawyer/.scripts/:/home/rassawyer/.gem/:$PATH"
export VISUAL=vim
export EDITOR="$VISUAL"
export TO_OR=32
################################################################################


##ALIAS'S#######################################################################
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias conky='conkyscript && lxterminal && exit'
alias git-pl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
##SSH Key Configuration########################################################

eval "$(ssh-agent)"

##Set Commandline Prefix#######################################################
PS1='[\u@\h \W]\$ '

##OctOs Build Flags#############################################################
export CCACHE_DIR=$HOME/.ccache
export USE_CCACHE=1
export USE_PREBUILT_CHROMIUM=1
#set up ccache if not present
if [ ! -d "$CCACHE_DIR" ]; then
    $HOME/.ccache -M 50G
fi
################################################################################
