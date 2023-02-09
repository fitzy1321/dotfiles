# From bashbunni's pomadoro timer: https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106
# Mac setup for pomo
#  brew install caarlos0/tap/timer terminal-notifier

function pomx --description "Bashbunni's pomodoro mac terminal timer" --argument-names rtimer
    # set default timer length
    if test -z $rtimer
        set -f rtimer 10m
    end

    timer $rtimer && terminal-notifier -message Pomodoro \
        -title 'Break is over! Get back to work 😬' \
        -appIcon '~/Pictures/pumpkin.png' \
        -sound Crystal
end
