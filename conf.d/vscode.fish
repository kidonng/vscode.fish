if ! status -i || test "$TERM_PROGRAM" != vscode || test -n "$VSCODE_SHELL_INTEGRATION"
    exit
end

set -g VSCODE_SHELL_INTEGRATION 1

function __vsc_initialize -e fish_prompt
    functions -e __vsc_initialize

    function __vsc_command_output_start -e fish_preexec
        # Ignore commands with leading space
        # https://fishshell.com/docs/current/interactive.html#searchable-command-history
        string match -q -- " *" $argv && return

        printf "\e]633;C\007"
        printf "\e]633;E;%s\007" "$argv"
    end

    function __vsc_command_complete -e fish_postexec
        printf "\e]633;D;%s\007" $status
        __vsc_update_cwd
    end

    functions -c fish_prompt __vsc_fish_prompt

    function fish_prompt
        __vsc_prompt_start
        __vsc_fish_prompt
        __vsc_prompt_end
    end
end
