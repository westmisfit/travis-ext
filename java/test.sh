source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "test..."
cd $PROJECT_DIR
mvn -Dfile.encoding=UTF-8 -Dproject.build.sourceEncoding=UTF-8 test
