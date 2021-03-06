#prompt line
PROMPT='%F{red}[%~] %f'
RPROMPT='%F{red}%T%f'

# history specification
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

# auto-completion
autoload -U compinit
compinit
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1	# Because we didn't really complete anything
}
zstyle ':completion:::::' completer _force_rehash _complete _approximate 
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
setopt autocd

# make home and end key work + some other goodies
bindkey "^[[2~" overwrite-mode
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-search 
bindkey "^[[6~" down-line-or-search 
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^?" backward-delete-char

PATH=$PATH:/opt/picasa/bin

## open with
alias -s mov="mplayer"
alias -s avi="mplayer"
alias -s mkv="mplayer"
alias -s mp4="mplayer"

## source aliases
if [ -f ~/.alias ]; then
	. ~/.alias
fi

## source autojump, and dont forget to use it!
if [[ -f /etc/profile.d/autojump.zsh ]]; then
	source /etc/profile.d/autojump.zsh
fi

##Disable system bell
setopt nobeep

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' force-list always

## precmd en exec
precmd() {
	case $TERM in
		screen-256color)
			print -Pn "\ek%c\e\\"
	esac
}

preexec () {
  case $TERM in
		screen-256color)
			command=$1
			if [[ $command == "ssh 192.168.0.100 -p 1312" ]]; then
					command="server"
			fi
			print -Pn "\ek$command\e\\"
	esac
}
