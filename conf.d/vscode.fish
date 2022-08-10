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
        printf "\e]633;E;%s\a" (
            string replace -a -- "\\" "\\\\" $argv |
            string replace -a ";" "\x3b" |
            string join "\x0a"
        )

        set -g _vsc_has_command
    end

    function __vsc_command_complete -e fish_postexec
        printf "\e]633;D;$status\a"
    end

    function __vsc_command_cancel -e fish_cancel
        printf "\e]633;E\a"
        printf "\e]633;D\a"
    end

    function __vsc_update_cwd -v PWD
        printf "\e]633;P;Cwd=$PWD\a"
    end

    function __vsc_check_command -e fish_prompt
        if set -q _vsc_has_command
            set -e _vsc_has_command
        else
            # Empty command, trigger cancel event
            __vsc_command_cancel
        end
    end

    functions -c fish_prompt __vsc_fish_prompt

    function fish_prompt
        printf "\e]633;A\a"
        __vsc_fish_prompt
        printf "\e]633;B\a"
    end
end
