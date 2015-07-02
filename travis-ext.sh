#!/bin/bash -e

TRAVIS_EXT_HOME=${TRAVIS_EXT_HOME-${HOME}/travis-ext}
BASH="bash -ex"
COMMAND="$1"

if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh" ]]; then
    $BASH $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh
elif [[ -f "$TRAVIS_EXT_HOME/share/$COMMAND.sh" ]]; then
    $BASH $TRAVIS_EXT_HOME/share/$COMMAND.sh
fi