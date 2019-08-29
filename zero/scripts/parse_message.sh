

. config.sh

# echo "[$(date)] ${USER}> ${MSG}" >> chat.log

KEY=$1
VALUE=$2

case $KEY in
    log)
        echo "log=$KEY <<< ${VALUE}"
        ;;

    quality)
        echo "log=Change quality from ${jpgQuality}% to ${VALUE}%"
        ;;
    interval)
        echo "log=Change sleepInterval from ${sleepInterval}sec to ${VALUE}sec"
        ;;

    stayawake)
        echo "log=Change stayawake from ${stayAwake} to ${VALUE}"
        ;;

    *)
        echo "[$KEY] >>> ${VALUE}"
        ;;
esac

