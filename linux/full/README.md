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