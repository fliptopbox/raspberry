

. config.sh

# echo "[$(date)] ${USER}> ${MSG}" >> chat.log

KEY=$1
VALUE=$2
TEMP=0

save_config () {
    local NAME=$1
    local VALUE=$2

    sed -i  "s/${NAME}=.*/${NAME}=${VALUE}/g" config.sh
    echo "log=Change ${NAME} to ${VALUE}"

}

case $KEY in
    log)
        echo "log=$KEY <<< ${VALUE}"
        ;;

    encoding|\
    exposure|\
    ev|\
    awb|\
    sharpness|\
    contrast|\
    saturation|\
    brightness|\
    imxfx|\
    metering|\
    rotation|\
    drc|\
    ISO|\
    quality)
        save_config "$KEY" "$VALUE"
        ;;

    quality)
        save_config "jpgQuality" "$VALUE"
        ;;

    iso)
        save_config "ISO" "$VALUE"
        ;;

    interval)
        save_config "sleepInterval" "$VALUE"
        ;;

    stayawake)
        echo "log=Change stayawake from ${stayAwake} to ${VALUE}"

        TEMP=false
        if [ $VALUE == true ]; then
            TEMP=true
        fi

        save_config "sleepInterval" "$TEMP"
        ;;

    *)
        echo "[$KEY] >>> ${VALUE}"
        ;;
esac

