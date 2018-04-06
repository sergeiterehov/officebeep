function beep {
    aplay "${soundFile}" > /dev/null 2>&1
}

function query {
    msg=$1

    if [[ $1 = $code ]]
    then
        beep
    fi
}

nc -lk 4444 | while read -r line; do query "$line"; done
echo "Office beep is stopped."
