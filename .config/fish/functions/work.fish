function work --description "Bashbunni's pomo mac terminal timer"
    # From bashbunni's pomadoro timer: https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106
    # Mac setup for pomo
    timer 60m && terminal-notifier -message 'Pomodoro'\
                -title 'Work Timer is up! Take a Break 😊'\
                -appIcon '~/Pictures/pumpkin.png'\
                -sound Crystal
end
