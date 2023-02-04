function pomw --description "Bashbunni's pomo mac terminal timer" --argument-names wtimer
    # set default timer length
    if test -z $wtimer # test -z checks for zero length strings
        set -f wtimer 60m # set function var
    end

    # From bashbunni's pomadoro timer: https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106
    # Mac setup for pomo
    timer $wtimer && terminal-notifier -message Pomodoro \
        -title 'Work Timer is up! Take a Break 😊' \
        -appIcon '~/Pictures/pumpkin.png' \
        -sound Crystal
end

#  brew install caarlos0/tap/timer terminal-notifier
