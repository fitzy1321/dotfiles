function pomx --description "Bashbunni's pomo mac terminal timer" --argument-names rtimer
    # set default timer length
    if test -z $rtimer # test -z checks for zero length strings
        set -f rtimer 10m # set function var
    end

    # From bashbunni's pomadoro timer: https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106
    # Mac setup for pomo
    timer $rtimer && terminal-notifier -message Pomodoro \
        -title 'Break is over! Get back to work 😬' \
        -appIcon '~/Pictures/pumpkin.png' \
        -sound Crystal
end

#  brew install caarlos0/tap/timer terminal-notifier
