function __vsc_command_output_start -e fish_preexec
    printf "\033]633;C\007"
    printf "\033]633;E;%s\007" "$argv"
end

function __vsc_command_complete -e fish_postexec
    printf "\033]633;D;%s\007" $status
    __vsc_update_cwd
end

functions -q __vsc_fish_prompt && exit
functions -c fish_prompt __vsc_fish_prompt

function fish_prompt
    __vsc_prompt_start
    __vsc_fish_prompt
    __vsc_prompt_end
end

if functions -q fish_right_prompt
    functions -c fish_right_prompt __vsc_fish_right_prompt

    function fish_right_prompt
        __vsc_right_prompt_start
        __vsc_fish_right_prompt
        __vsc_right_prompt_end
    end
end
