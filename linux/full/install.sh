#!/bin/bash

# Parse inputs
while getopts r:v:f: flag
do
    case "${flag}" in
        r) REGISTRY_TOKEN=${OPTARG};;
        v) VERSION=${OPTARG};;
        f) fullname=${OPTARG};;
    esac
done

STEPS=7
PATH_PREFIX='./test'

# Create opt folder
BINARY_FILE_PATH="$PATH_PREFIX/opt/kapsul"
echo "Step 1/$STEPS. Creating folder $BINARY_FILE_PATH ..."
    mkdir -p $BINARY_FILE_PATH

# Get the JAR file
echo "Step 2/$STEPS. Getting the jar file ..."
    #curl --header "PRIVATE-TOKEN:$REGISTRY_TOKEN" "https://code.fabrick.io/api/v4/projects/189/packages/generic/kapsul/1.0.7/kapsul.jar" --output $BINARY_FILE_PATH/kapsul-$VERSION.jar
echo -e "Step 2/$STEPS. Done.\n"

# Get the configuration file
echo -e "Step 3/$STEPS. Creating folder $CONFIG_FILE_PATH ...\n"
    CONFIG_FILE_PATH="$PATH_PREFIX/etc/kapsul"
    mkdir -p $CONFIG_FILE_PATH

# Get an edit confs files
echo "Step 4/$STEPS. Getting the configuration file ..."
    # To change
    cp ./configs/kapsul.conf $CONFIG_FILE_PATH/kapsul.conf
    cp ./configs/logback.xml $CONFIG_FILE_PATH/logback.xml
    #curl --header "PRIVATE-TOKEN:$REGISTRY_TOKEN" "https://code.fabrick.io/api/v4/projects/189/packages/generic/kapsul/1.0.7/kapsul.jar" --output kapsul-$VERSION.jar

    # Edit conf file
    DATA_FOLDER=$BINARY_FILE_PATH/data
    mkdir -p $DATA_FOLDER
    sed -i '' "s|\$DATA_FOLDER|$DATA_FOLDER|g" "$CONFIG_FILE_PATH/kapsul.conf"

    # Edit logback file
    HOME_LOG="$PATH_PREFIX/var/logs"
    mkdir -p $HOME_LOG
    sed -i '' "s|\${HOME_LOG}|$HOME_LOG|g" "$CONFIG_FILE_PATH/logback.xml"

echo -e "Step 4/$STEPS. Done.\n"

# Key generation
echo "Step 5/$STEPS. Generating keys"
    ADMIN_KEY=$(uuidgen | sed -e "s/\-//g")
    sed -i '' "s|\$ADMIN_KEY|$ADMIN_KEY|g" "$CONFIG_FILE_PATH/kapsul.conf"
    echo "Admin key: $ADMIN_KEY"


    CLIENT_KEY=$(uuidgen | sed -e "s/\-//g") 
    sed -i '' "s|\$CLIENT_KEY|$CLIENT_KEY|g" "$CONFIG_FILE_PATH/kapsul.conf"
    echo "Client key: $CLIENT_KEY"
echo -e "Step 5/$STEPS. Done\n"

# Get the service file
echo "Step 6/$STEPS. Getting the service file ..."
    CONFIG_FILE_PATH="$PATH_PREFIX/etc/systemd/system/"
    mkdir -p $CONFIG_FILE_PATH
    touch $CONFIG_FILE_PATH/kapsul.service
    #curl --header "PRIVATE-TOKEN:$REGISTRY_TOKEN" "https://code.fabrick.io/api/v4/projects/189/packages/generic/kapsul/1.0.7/kapsul.jar" --output kapsul-$VERSION.jar
echo -e "Step 6/$STEPS. Done.\n"