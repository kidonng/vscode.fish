function __vsc_update_cwd
    printf "\e]633;P;Cwd=%s\007" "$PWD"
end
