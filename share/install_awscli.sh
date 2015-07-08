source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

if [[ "$TRAVIS_OS_NAME" = "linux" ]]; then
    sudo apt-get update
    sudo apt-get install -y python-pip 
    sudo pip install awscli
elif [[ "$TRAVIS_OS_NAME" = "osx" ]]; then
    sudo easy_install pip
    sudo pip install awscli
else
    echo "Unknown OS: '$TRAVIS_OS_NAME'"
fi
