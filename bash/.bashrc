# .bashrc

# -- Improved X11 forwarding through GNU Screen (or tmux).
# If not in screen or tmux, update the DISPLAY cache.
# If we are, update the value of DISPLAY to be that in the cache.
function update-x11-forwarding
{
  TDN=`tmux display-message -p '#S'`
  NOW=`date`
  # The following line fills up the log quickly:
  #echo "$NOW : $TDN" >> ~/.display.log
  if [ "left" = "$TDN" ]; then 
    export DISPLAY=`cat ~/.displayLeft.txt`
  fi    
  if [ "right" = "$TDN" ]; then 
    export DISPLAY=`cat ~/.displayRight.txt`
  fi
}


#################################################################
# Source global definitions
#################################################################
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Source aliases
if [ -f ~/.bash_prompt ]; then
	. ~/.bash_prompt
fi

#################################################################
# This is run before every command.
#################################################################
source ~/.bash_preexec
preexec() {
  # Don't cause a preexec for PROMPT_COMMAND.
  # Beware!  This fails if PROMPT_COMMAND is a string containing more than one command.
  [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return

  # Debugging.
  #echo DISPLAY = $DISPLAY, display.txt = `cat ~/.display.txt`, STY = $STY, TMUX = $TMUX
}

update-x11-forwarding
preexec_install
