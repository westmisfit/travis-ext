source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "maven install dependencies..."
cd $PROJECT_DIR
mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V
