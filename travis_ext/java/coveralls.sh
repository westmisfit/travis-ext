source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "upload coveralls..."
cd $PROJECT_DIR
mvn -Dfile.encoding=UTF-8 -Dproject.build.sourceEncoding=UTF-8 clean cobertura:cobertura coveralls:report
