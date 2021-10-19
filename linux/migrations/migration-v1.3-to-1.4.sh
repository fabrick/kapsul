#!/bin/bash

RELEASE="2.2.1"

# Parse inputs
while getopts r:v:u:t: flag
do
    case "${flag}" in
        h)
            echo "Use the following flags:"
            echo "  -r"
            echo "    to set registry token"
            echo "  -u"
            echo "    user to use"
            echo "  -h"
            echo "    to show help"
            echo ""
            exit 100
            ;;
        r) REGISTRY_TOKEN=${OPTARG};;
        u) KAPSUL_USER=${OPTARG};;
        t) TEST=true;;
        \?)
            echo "Invalid option: -${OPTARG}"
            ;;
    esac
done

systemctl is-active --quiet kapsul
if [ $? -eq 0 ]
then
    systemctl stop kapsul
    curl --header "PRIVATE-TOKEN:$REGISTRY_TOKEN" "https://code.fabrick.io/api/v4/projects/189/packages/generic/kapsul/1.4.0/kapsul.jar" --output $BINARY_FILE_PATH/kapsul.jar 
    # Get the service file
    echo "Step 6/$STEPS. Getting the service file ..."
    getJava
    SERVICE_FILE_PATH="$PATH_PREFIX/etc/systemd/system/"
    mkdir -p $SERVICE_FILE_PATH
    curl "https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/configs/kapsul.service" -o $SERVICE_FILE_PATH/kapsul.service
    
    sed -i "s|\$KAPSUL_USER|root|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$KAPSUL_WORK_DIR|$BINARY_FILE_PATH|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$JAVA_PATH|$JAVA_PATH|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$KAPSUL_CONFIG_PATH|$CONFIG_FILE_PATH/kapsul.conf|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$LOGBACK_CONFIG_PATH|$CONFIG_FILE_PATH/logback.xml|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$KAPSUL_JAR_PATH|$BINARY_FILE_PATH/kapsul-.jar|g" "$SERVICE_FILE_PATH/kapsul.service"
    systemctl daemon-reload
    systemctl enable kapsul.service
    systemctl start kapsul

else
    echo "Kapsul not installed."
fi