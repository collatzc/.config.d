if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g theme_color_scheme ayu
set --universal ayu_variant mirage && ayu_load_theme
set -g theme_display_git_default_branch yes
