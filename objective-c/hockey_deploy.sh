source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

echo "archive output for hockey..."

HOCKEY_DIR="$HOME/hockey"
OUTPUT_DIR="$PROJECT_DIR"

echo "create hockey dir..."
mkdir -p $HOCKEY_DIR
cd $HOCKEY_DIR
touch .keep
pwd

echo "clean..."
rm -rf *.ipa *.plist *.html

# copy .ipa file
for file in $OUTPUT_DIR/*.ipa
do
    if [ -f "${file}" ]; then
        echo "copy ${file} file..."
        cp ${file} ./

        break
    fi
done

# copy Info.plist file
for file in $OUTPUT_DIR/*.dSYM.zip
do
    if [ -f "${file}" ]; then
        echo "copy ${file} file..."
        cp ${file} ./
        unzip ${file}
        cp *.dSYM/Contents/*.plist .
        rm -rf *.dSYM
        rm ${file}

        break
    fi
done

# copy history.html file
for file in $OUTPUT_DIR/*.java
do
    if [ -f "${file}" ]; then
        echo "copy ${file} file..."
        # TODO

        break
    fi
done

echo "upload hockey dir to S3"
aws s3 sync . "s3://${S3_HOCKEY_BUCKET_NAME}/hockey/${BUNDLE_IDENTIFIER}_${TRAVIS_BRANCH//\//_}/build_${TRAVIS_BUILD_NUMBER}"

echo "trigger hockey to sync S3 hockey dir..."
curl http://hk.int.misfit.com/sync.php

