function pomx --description "Bashbunni's pomodoro mac terminal timer"
    # From bashbunni's pomadoro timer: https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106
    # Mac setup for pomo
    timer 10m && terminal-notifier -message Pomodoro \
        -title 'Break is over! Get back to work 😬' \
        -appIcon '~/Pictures/pumpkin.png' \
        -sound Crystal
end
