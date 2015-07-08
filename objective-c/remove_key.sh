source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

# PROFILE_NAME=

echo "remove keys..."
security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$PROFILE_NAME.mobileprovision
