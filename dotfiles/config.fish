# this is only displayed in interactive shells
set fish_greeting ""

# greet once per pid
if not test -f /tmp/.greeting.$fish_pid
    echo "           $(set_color blue)_$(set_color normal)      _        _ _"
    echo " $(set_color blue) _ _  ___| |_ $(set_color normal)__| |_  ___| | |"
    echo " $(set_color blue)| ' \\/ -_)  _$(set_color normal)(_-< ' \\/ -_) | |"
    echo " $(set_color blue)|_||_\\___|\\__$(set_color normal)/__/_||_\\___|_|_|  version 1.0"
    echo ""
    echo " $(set_color white)https://github.com/redimp/netshell$(set_color -o normal)"
    echo ""
    touch /tmp/.greeting.$fish_pid
end
