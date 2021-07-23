#!/usr/bin/env fish
#
# tide configuration docs:
# https://github.com/IlanCosman/tide/wiki/Configuration
#
# linting: [`fish --no-execute`](https://fishshell.com/docs/current/cmds/fish.html)
# formatting: ***(Changes file in place)*** [`fish_indent --ansi --write`](https://fishshell.com/docs/current/cmds/fish_indent.html)
# via the [tide contribution guidelines](https://github.com/IlanCosman/tide/blob/main/CONTRIBUTING.md)
#
# quick development loop commands:
#
# ```
# fish --no-execute functions/setup-diff-tide-prompt.fish
# fish --ansi --write
# source functions/setup-diff-tide-prompt.fish
#
# setup-diff-tide-prompt
# ```

# todo(alice) make this command take arguments?
function setup-diff-tide-prompt

    # todo(alice) would it be useful to have a printer for generic
    # settings/variable changes?
    set -U tide_print_newline_before_prompt true
    set -U tide_context_always_display true
    set -U tide_pwd_truncate_margin 60

    echo "\t\tSet tide display variables:
        set -U tide_print_newline_before_prompt true
        set -U tide_context_always_display true
        set -U tide_pwd_truncate_margin 60
        "

    set -l _diff_left_prompt \
        os jobs context \
        newline \
        rust virtual_env chruby nvm status vi_mode prompt_char

    set -l _diff_right_prompt \
        cmd_duration pwd \
        newline \
        git

    _diff_print_tide_prompt_setters "Replacing prompt settings:" "$tide_left_prompt_items" "$tide_right_prompt_items"
    _diff_print_tide_prompt_setters "New prompt settings:" "$_diff_left_prompt" "$_diff_right_prompt"

    set -U tide_left_prompt_items $_diff_left_prompt
    set -U tide_right_prompt_items $_diff_right_prompt

    echo Prompt set! \(But give it a minute to show up, it\'s async.\)
end

function _diff_print_tide_prompt_setters -a intro_text left_prompt right_prompt

    echo $intro_text

    set -l _prompt_log "
set -U tide_left_prompt_items \\
    $left_prompt

set -U tide_right_prompt_items \\
    $right_prompt
"

    echo $_prompt_log | sed 's/newline /\\\\\n    newline \\\\\n    /'

end
