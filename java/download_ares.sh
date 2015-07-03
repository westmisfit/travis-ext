source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "download ares client..."
curl http://$ARES_SERVER/downloads/ares-linux-386.tar.gz | tar xzv
mv ares $HOME/
