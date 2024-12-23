# Set the prompt ##############################################################
export PROMPT="%K{#FF0090}%F{#000000}%B%n%b%f%k@%m %S%~%s %# ➜  "
PS1=$PROMPT

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red  
RPROMPT='%B%K{#FBFF5F}%F{#14103B}${vcs_info_msg_0_}%f%k%b'

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# PS1="%(?:%{%}%1{➜%} :%{%}%1{➜%} ) %{%}%c%{%} "

## Bring in my aliases ########################################################
source $HOME/.scripts/dotFiles/zsh/alias.conf

## ZSH Options ################################################################
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
_comp_options+=(globdots) # With hidden files
source $HOME/.config/zsh/completion.zsh

## OPENING SCREEN GEMS #########################################################
## Only if not in Tmux #########################################################
if ! { [ "$TERM" = "tmux-256color" ] && [ -n "$TMUX" ]; } then
	[[ $- != *i* ]] && return
	a=`echo $(( (RANDOM % 4 ) +1))`

	if [ $a = "1" ] ;	then
		cmatrix -s

	elif [ $a = "2" ] ;	then
		fortune | cowsay

	elif [ $a = "3" ] ;	then
		archey3

#	elif [ $a = "4" ];	then
#		sl

#
	else 
		asciiquarium
	fi
fi
## Add deno completions to search path ########################################
if [[ ":$FPATH:" != *":/home/rassawyer/.zsh/completions:"* ]]; then export FPATH="/home/rassawyer/.zsh/completions:$FPATH"; fi

# Lines configured by zsh-newuser-install #####################################
HISTFILE=$ZDOTDIR/zsh/zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rassawyer/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
. "/home/rassawyer/.deno/env"

## Make keys work normally in zsh #############################################

bindkey "" backward-delete-char
bindkey "[2~" overwrite-mode
bindkey "OH" beginning-of-line
bindkey "[5~" up-line-or-history
bindkey "[3~" delete-char
bindkey "OF" end-of-line
bindkey "[6~" down-line-or-history
bindkey "OA" up-line-or-search
bindkey "OD" backward-char
bindkey "OB" down-line-or-search
bindkey "OC" forward-char
