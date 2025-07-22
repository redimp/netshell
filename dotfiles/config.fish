# this is only displayed in interactive shells
set fish_greeting ""

function cheatsh --description "Streamline cheat.sh call"
    curl -s "https://cheat.sh/$argv"
end
