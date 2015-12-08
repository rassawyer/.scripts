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
export USE_CCACHE=1
##ALIAS'S#######################################################################
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias conky='conkyscript && lxterminal && exit'
################################################################################
PS1='[\u@\h \W]\$ '
