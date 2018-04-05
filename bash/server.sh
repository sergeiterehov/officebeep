function beep {
    aplay "${soundFile}"
}

function query {
    msg=$1

    echo "[$msg]"

    if [[ $1 = $code ]]
    then
        beep
    fi
}

nc -lk 4444 | while read -r line; do query "$line"; done