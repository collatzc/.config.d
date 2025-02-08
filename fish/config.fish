set fish_greeting ""

set -gx TERM xterm-256color

if status is-interactive
    # Commands to run in interactive sessions can go here
end

command -qv nvim && alias vim nvim

set -g theme_display_git_default_branch yes

# bobthefish
set -g theme_nerd_fonts yes
set -g theme_color_scheme zenburn
set -g theme_display_user no
