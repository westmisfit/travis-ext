source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "archive output for hockey..."

HOCKEY_DIR="$HOME/hockey"
OUTPUT_DIR="$PROJECT_DIR"

if [[ "$ANDROID_MODULE" != "" ]]; then
    MODULE_DIR="$PROJECT_DIR/$ANDROID_MODULE"
else
    MODULE_DIR="$PROJECT_DIR"
fi

function get_version_name() {
    local gradle_file=$1
    if [[ ! -f "$gradle_file" ]]; then
        >&2 echo "$gradle_file does not exists."
        exit 1
    fi
    local version_name=$( grep versionName $gradle_file | cut -d '"' -f2 )
    echo $version_name
}

VERSION_NAME=$( get_version_name $MODULE_DIR/build.gradle )

echo VERSION_NAME=$VERSION_NAME


echo "create hockey dir..."
mkdir -p $HOCKEY_DIR
cd $HOCKEY_DIR
touch .keep
pwd

echo "clean..."
rm -rf *.apk *.html

# copy .apk file
for file in $( find $OUTPUT_DIR -name *-debug.apk )
do
    if [ -f "${file}" ]; then
        echo "copy ${file} file..."
        cp ${file} ./

        break
    fi
done

# generate info.json file
echo '{
    "title":"'$APP_NAME' ('${TRAVIS_BRANCH//\//_}')",
    "versionCode":'$TRAVIS_BUILD_NUMBER',
    "versionName":"'$VERSION_NAME'"
}' > ./info.json

# copy history.html file
for file in $( find $OUTPUT_DIR -name *.html )
do
    if [ -f "${file}" ]; then
        echo "copy ${file} file..."
        cp ${file} ./

        break
    fi
done

echo "upload hockey dir to S3"
aws s3 sync . "s3://${S3_HOCKEY_BUCKET_NAME}/hockey/${BUNDLE_IDENTIFIER}_${TRAVIS_BRANCH//\//_}/build_${TRAVIS_BUILD_NUMBER}"

echo "trigger hockey to sync S3 hockey dir..."
curl http://hk.int.misfit.com/sync.php

