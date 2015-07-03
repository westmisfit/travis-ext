echo "upload coveralls..."
mvn -Dfile.encoding=UTF-8 -Dproject.build.sourceEncoding=UTF-8 clean cobertura:cobertura coveralls:report
