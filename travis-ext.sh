#!/bin/bash -e

TRAVIS_EXT_HOME=${TRAVIS_EXT_HOME-${HOME}/travis-ext}
# TRAVIS_EXT_OPTIONS="x"  # set 'x' to print all shell scripts

COMMAND="$1"

if [[ "TRAVIS_EXT_HOME" = "" ]]; then
    echo "Not setted 'TRAVIS_EXT_HOME'"
    exit 1
fi

if [[ "PROJECT_LANGUAGE" = "" ]]; then
    echo "Not setted 'PROJECT_LANGUAGE'"
    exit 1
elif [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/verify_vars.sh" ]]; then
    # verify environment by different language
    bash -e$TRAVIS_EXT_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/verify_vars.sh
fi

if [[ "COMMAND" = "" ]]; then
    # print help message if no command
    COMMAND="help"
fi

if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh" ]]; then
    # run script by different language
    bash -e$TRAVIS_EXT_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh
elif [[ -f "$TRAVIS_EXT_HOME/share/$COMMAND.sh" ]]; then
    # run script shared with all languages
    bash -e$TRAVIS_EXT_OPTIONS $TRAVIS_EXT_HOME/share/$COMMAND.sh
fi