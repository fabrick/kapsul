## Ubuntu installation
### Dependencies
First, you need to install dependencies:
* Java 8 : ``sudo apt install openjdk-8-jre-headless``
* curl : ``sudo apt install curl``

### Start the script
`` curl -Ls curl -o- https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/install.sh | sudo bash -s -- -r $TOKEN -v $VERSION ``

Where :
* $TOKEN is the secret token to access Fabrick repository
* $VERSION is the version of Kapsul


## CentOS installation
### Dependencies
First, you need to install dependencies:
* Java 8 : ``sudo yum install java-1.8.0-openjdk``

### Start the script
`` curl -Ls curl -o- https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/install.sh | sudo bash -s -- -r $TOKEN -v $VERSION ``

Where :
* $TOKEN is the secret token to access Fabrick repository
* $VERSION is the version of Kapsul

## Debian installation
### Dependencies

First, you need to install dependencies:
* Java 11 : ``sudo apt-get install openjdk-11-jre-headless``
* curl : ``sudo apt-get install curl``
* uuidgen : ``sudo apt-get install uuid-runtime``
* update certificates : ``sudo apt-get install ca-certificates``

### Start the script
`` curl -Ls curl -o- https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/install.sh | sudo bash -s -- -r $TOKEN -v $VERSION ``

Where :
* $TOKEN is the secret token to access Fabrick repository
* $VERSION is the version of Kapsul

## SUSE, SUSE Linux Enterprise Server 15 installation
### Dependencies

First, you need to install dependencies:
* Java 11 : ``sudo zypper install -y java-11-openjdk-headless``

### Start the script
`` curl -Ls curl -o- https://raw.githubusercontent.com/fabrick/kapsul/main/linux/full/install.sh | sudo bash -s -- -r $TOKEN -v $VERSION ``

Where :
* $TOKEN is the secret token to access Fabrick repository
* $VERSION is the version of Kapsul