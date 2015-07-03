echo "upload coveralls..."
mvn -DTRAVIS_JOB_ID=$TRAVIS_JOB_ID -Dfile.encoding=UTF-8 -Dproject.build.sourceEncoding=UTF-8 clean cobertura:cobertura coveralls:report
