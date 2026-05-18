if status is-interactive
# Commands to run in interactive sessions can go here
end

set -g fish_greeting ""

/usr/bin/mise activate fish | source

starship init fish | source
