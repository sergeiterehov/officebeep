function stop {
    cd $local
    exit $1
}

local=$(pwd)
cd $dir

pid=$( ps ax | grep "nc" | grep "4444" | sed -r "s/\s?([0-9]*).*/\1/" )

if [[ $pid = '' ]]
then
    if [[ $1 = '' ]]
    then
        eval "bash ./pop.sh --officebeep &"

        echo "Process is started."
        stop 0
    fi
    
    echo "Process not found. Use \"pop\" to start service!"
    stop 0
else
    if [[ $1 = 'out' ]]
    then
        kill -9 $pid

        echo "Stopped!"
        stop 0
    fi

    echo "Process already started!"
    stop 0
fi