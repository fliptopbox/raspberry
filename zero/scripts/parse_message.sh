

. config.sh

# echo "[$(date)] ${USER}> ${MSG}" >> chat.log

KEY=$1
VALUE=$2
TEMP=0

save_config () {
    local NAME=$1
    local VALUE=$2

    sed -i  "s/${NAME}=.*/${NAME}=${VALUE}/g" config.sh
    echo "log=Change [${NAME}] to [${VALUE}]"

}

case $KEY in
    log)
        echo "log=$KEY <<< ${VALUE}"
        ;;

    bracket|\
    exposure|\
    ev|\
    sharpness|\
    contrast|\
    saturation|\
    brightness|\
    rotation|\
    ISO|\
    interval|\
    quality)
        # Numeric values
        save_config "$KEY" "$VALUE"
        ;;

    awb|\
    drc|\
    encoding|\
    exposure|\
    imxfx|\
    metering)
        # ENUM (string) values
        save_config "$KEY" "$VALUE"
        ;;

    preview|\
    stayawake)

        TEMP=false
        if [ $VALUE == true ]; then
            TEMP=true
        fi

        if [ "$KEY" == "stayAwake" ]; then
            KEY=stayAwake
        fi

        save_config "$KEY" "$TEMP"
        ;;

    *)
        echo "[$KEY] >>> ${VALUE}"
        ;;
esac

case $KEY in

    interval|\
    preview)

        echo "log=parse;force reload;$KEY=$VALUE"
        ./capture.sh "force" &
        ;;

esac
