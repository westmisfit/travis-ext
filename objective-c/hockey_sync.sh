source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "trigger hockey to sync S3 hockey dir..."
curl http://hk.int.misfit.com/sync.php
