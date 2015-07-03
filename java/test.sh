source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "test..."
mvn -Dfile.encoding=UTF-8 -Dproject.build.sourceEncoding=UTF-8 test
