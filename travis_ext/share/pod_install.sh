source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "pod install dependencies..."
cd $PROJECT_DIR
pod install
