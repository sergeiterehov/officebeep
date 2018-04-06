function stop {
    cd $local
    exit $1
}

local=$(pwd)
cd $dir

if [[ $1 = 'add' ]]
then
    name=$( echo $2 | sed "s/[^a-zA-Z]//g" )

    if [[ "$name" = "" ]]
    then
        echo "Name error! Use letters only (ex.: ivan, Alex)."
        stop 0
    fi

    ip=$( echo $3 )

    if [[ ! "$ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
    then
        echo "IP format error! Ex.: 192.168.12.42"
        stop 0
    fi

    exists=$( grep "$name" ./config/people.sh )

    if [[ ! $exists = '' ]]
    then
        echo "Name \"$name\" already exists (in config/people.sh): $exists"
        stop 0
    fi

    echo "$name=\"$ip\"" >> ./config/people.sh

    echo "Name \"$name\" added -> $ip"
    exit 0
fi

name=$1

if [[ $name = "" ]]
then
    echo "Please enter a name! Ex.: push me"
    stop 0
fi

eval "bash ./push.sh $1"

stop 0