source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

# CERT_DIR=
# PROFILE_DIR=
# PROFILE_NAME=

echo "add keys..."

security create-keychain -p travis ios-build.keychain
# security default-keychain -s ios-build.keychain
security unlock-keychain -p travis ios-build.keychain
# security set-keychain-settings -t 3600 -u iso-build.keychain
ls -la ~/Library/Keychains

security import $CERT_DIR/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import $CERT_DIR/dist.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import $CERT_DIR/dist.p12 -k ~/Library/Keychains/ios-build.keychain -P test -T /usr/bin/codesign

security list-keychains -s ios-build.keychain
security list-keychains

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp $PROFILE_DIR/$PROFILE_NAME.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/

ls -al ~/Library/MobileDevice/Provisioning\ Profiles/
ls -al ~/Library/Keychains/
ls -al /Users/travis/Library/Keychains
