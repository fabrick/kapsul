#!/bin/bash

RELEASE="2.2.1"


# If test mode enable, add relative path
if [ "$TEST" = true ] ; then
    PATH_PREFIX='./test'
else 
    PATH_PREFIX=''
fi

BINARY_FILE_PATH="$PATH_PREFIX/opt/kapsul"


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

systemctl is-active --quiet kapsul
if [ $? -eq 0 ]
then
    systemctl stop kapsul
    curl --header "PRIVATE-TOKEN:$REGISTRY_TOKEN" "https://code.fabrick.io/api/v4/projects/189/packages/generic/kapsul/1.6.3/kapsul.jar" --output $BINARY_FILE_PATH/kapsul.jar 
    # Get the service file
    echo "Step 6/$STEPS. Getting the service file ..."
    getJava
    CONFIG_FILE_PATH="$PATH_PREFIX/etc/kapsul"
    SERVICE_FILE_PATH="$PATH_PREFIX/etc/systemd/system/"
    BINARY_FILE_PATH="$PATH_PREFIX/opt/kapsul"
    mkdir -p $SERVICE_FILE_PATH
    curl "https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/configs/kapsul.service" -o $SERVICE_FILE_PATH/kapsul.service
    
    sed -i "s|\$KAPSUL_USER|root|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$KAPSUL_WORK_DIR|$BINARY_FILE_PATH|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$JAVA_PATH|$JAVA_PATH|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$KAPSUL_CONFIG_PATH|$CONFIG_FILE_PATH/kapsul.conf|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$LOGBACK_CONFIG_PATH|$CONFIG_FILE_PATH/logback.xml|g" "$SERVICE_FILE_PATH/kapsul.service"
    sed -i "s|\$KAPSUL_JAR_PATH|$BINARY_FILE_PATH/kapsul.jar|g" "$SERVICE_FILE_PATH/kapsul.service"
    systemctl daemon-reload
    systemctl enable kapsul.service
    systemctl start kapsul

else
    echo "Kapsul not installed."
fi
