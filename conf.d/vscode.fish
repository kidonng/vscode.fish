if ! status -i || test "$TERM_PROGRAM" != vscode || test -n "$VSCODE_SHELL_INTEGRATION"
    exit
end

set -g VSCODE_SHELL_INTEGRATION 1

function __vsc_initialize -e fish_prompt
    functions -e __vsc_initialize

    function __vsc_command_output_start -e fish_preexec
        # Ignore commands with leading spaces or in private mode
        if string match -q -- " *" $argv || test -n "$fish_private_mode"
            set argv ""
        end

        printf "\e]633;C\a"
        printf "\e]633;E;$argv\a"
    end

    function __vsc_command_complete -e fish_postexec
        printf "\e]633;D;$status\a"
        printf "\e]633;P;Cwd=$PWD\a"
    end

    functions -c fish_prompt __vsc_fish_prompt

    function fish_prompt
        printf "\e]633;A\a"
        __vsc_fish_prompt
        printf "\e]633;B\a"
    end
end
