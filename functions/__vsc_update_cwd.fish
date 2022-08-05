function __vsc_update_cwd
    printf "\033]633;P;Cwd=%s\007" "$PWD"
end
