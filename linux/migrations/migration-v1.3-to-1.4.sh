RELEASE="2.2.1"

# Parse inputs
while getopts r:v:u:t: flag
do
    case "${flag}" in
        h)
            echo "Use the following flags:"
            echo "  -r"
            echo "    to set registry token"
            echo "  -v"
            echo "    to set Kapsul version"
            echo "  -u"
            echo "    user to use"
            echo "  -h"
            echo "    to show help"
            echo ""
            exit 100
            ;;
        r) REGISTRY_TOKEN=${OPTARG};;
        v) VERSION=${OPTARG};;
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
    curl --header "PRIVATE-TOKEN:$REGISTRY_TOKEN" "https://code.fabrick.io/api/v4/projects/189/packages/generic/kapsul/$VERSION/kapsul.jar" --output $BINARY_FILE_PATH/kapsul.jar 
else
    echo "Kapsul not installed."