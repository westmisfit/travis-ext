source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

if [[ "$ENABLE_ARES" = "true" ]]; then
    echo "deploy with ares..."
    $HOME/ares
fi
