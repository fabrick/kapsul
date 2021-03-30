#!/bin/bash

##
## Kapsul installation script.
## Copyright (c) 2021 Fabrick (https://fabrick.io)
##
## This script is inspired from :
## * Root and systemd checks : thanks to Aaron Murray (Github: ryecoaaron) (https://github.com/OpenMediaVault-Plugin-Developers/installScript/blob/master/install) 
## * Java check : thanks to glenn jackman (https://stackoverflow.com/a/7335524/2806806)
##
## Version 1.0.0
##

# Check for root
if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be executed as root or using sudo."
  exit 99
fi

# Check for systemd
systemd="$(ps --no-headers -o comm 1)"
if [ ! "${systemd}" = "systemd" ]; then
  echo "This system is not running systemd.  Exiting..."
  exit 100
fi

function getJava() {
    if type -p java; then
        echo found java executable in PATH
        _java=$(which java)
    elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
        echo found java executable in JAVA_HOME     
        _java="$JAVA_HOME/bin/java"
    else
        echo "No java found. Please install a Java Runtime v1.8"
        exit 101
    fi

    if [[ "$_java" ]]; then
        fullversion=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
        version=${fullversion:0:3}
        echo version "$fullversion"
        if [[ "$version" = "1.8" ]]; then
            JAVA_PATH=$_java
        else         
            echo "Version is different from version 1.8. Kapsul may not work"
            JAVA_PATH=$_java
        fi
    fi
}

# Default user
KAPSUL_USER=root

# Parse inputs
while getopts v:u:t: flag
do
    case "${flag}" in
        h)
            echo "Use the following flags:"
            echo "  -v"
            echo "    to set Kapsul version"
            echo "  -u"
            echo "    user to use"
            echo "  -h"
            echo "    to show help"
            echo ""
            exit 100
            ;;
        v) VERSION=${OPTARG};;
        u) KAPSUL_USER=${OPTARG};;
        t) TEST=true;;
        \?)
            echo "Invalid option: -${OPTARG}"
            ;;
    esac
done

STEPS=7

# If test mode enable, add relative path
if [ "$TEST" = true ] ; then
    PATH_PREFIX='./test'
else 
    PATH_PREFIX=''
fi

# Create opt folder
BINARY_FILE_PATH="$PATH_PREFIX/opt/kapsul"
echo "Step 1/$STEPS. Creating folder $BINARY_FILE_PATH ..."
    mkdir -p $BINARY_FILE_PATH

# Get the JAR file
echo "Step 2/$STEPS. Getting the jar file ..."
    curl -L -o kapsul-$VERSION.jar https://github.com/fabrick/kapsul/releases/download/$VERSION/kapsul-demo.jar
echo -e "Step 2/$STEPS. Done.\n"

# Get the configuration file
echo -e "Step 3/$STEPS. Creating folder $CONFIG_FILE_PATH ...\n"
    CONFIG_FILE_PATH="$PATH_PREFIX/etc/kapsul"
    mkdir -p $CONFIG_FILE_PATH

# Get an edit confs files
echo "Step 4/$STEPS. Getting the configuration file ..."
    # Download conf files
    curl "https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/configs/kapsul.conf" -o $CONFIG_FILE_PATH/kapsul.conf
    curl "https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/configs/logback.xml" -o $CONFIG_FILE_PATH/logback.xml

    # Edit conf file
    DATA_FOLDER=$BINARY_FILE_PATH/data
    mkdir -p $DATA_FOLDER
    sed -i "s|\$DATA_FOLDER|$DATA_FOLDER|g" "$CONFIG_FILE_PATH/kapsul.conf"

    # Edit logback file
    HOME_LOG="$PATH_PREFIX/var/log"
    mkdir -p $HOME_LOG
    sed -i "s|\${HOME_LOG}|$HOME_LOG|g" "$CONFIG_FILE_PATH/logback.xml"

echo -e "Step 4/$STEPS. Done.\n"

# Key generation
echo "Step 5/$STEPS. Generating keys"
    ADMIN_KEY=$(uuidgen | sed -e "s/\-//g")
    sed -i "s|\$ADMIN_KEY|$ADMIN_KEY|g" "$CONFIG_FILE_PATH/kapsul.conf"
    echo "Admin key: $ADMIN_KEY"


    USER_KEY=$(uuidgen | sed -e "s/\-//g") 
    sed -i "s|\$USER_KEY|$USER_KEY|g" "$CONFIG_FILE_PATH/kapsul.conf"
    echo "Client key: $USER_KEY"
echo -e "Step 5/$STEPS. Done\n"

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
    sed -i "s|\$KAPSUL_JAR_PATH|$BINARY_FILE_PATH/kapsul-$VERSION.jar|g" "$SERVICE_FILE_PATH/kapsul.service"

echo -e "Step 6/$STEPS. Done.\n"

echo "Step 7/$STEPS. Addind Kapsul to systemd ..."
    systemctl daemon-reload
    systemctl enable kapsul.service
    systemctl start kapsul
echo -e "Step 7/$STEPS. Done, enjoy :)\n"