# Commands to run in interactive sessions can go here
starship init fish | source
alias ll 'lsd -lh --group-dirs=first'
alias la 'lsd -a --group-dirs=first'
alias l 'lsd --group-dirs=first'
alias lla 'lsd -lha --group-dirs=first'
alias ls 'lsd --group-dirs=first'
alias cat bat


# Quitar el mensaje de bienvenida
set -U fish_greeting

#Envs
#export PATH="$HOME/.cargo/bin:$PATH"
