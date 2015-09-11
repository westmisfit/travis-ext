#!/bin/bash -e

#
# Warning:
# 
# If export and set in one line, it will not exit when detect_language.py exit with code 1
#
# Error Code:
#    export PROJECT_LANGUAGE="$( python ${TRAVIS_EXT_HOME}/detect_language.py )"
#
# Right Code:
#    PROJECT_LANGUAGE="$( python ${TRAVIS_EXT_HOME}/detect_language.py )"; export PROJECT_LANGUAGE;
#    
#

# public vars for all languages
TRAVIS_EXT_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; export TRAVIS_EXT_HOME;
TRAVIS_EXT="${TRAVIS_EXT_HOME}/travis-ext.sh"; export TRAVIS_EXT;
PROJECT_DIR="${PROJECT_DIR-$TRAVIS_BUILD_DIR}"; export PROJECT_DIR;
PROJECT_LANGUAGE="${TRAVIS_LANGUAGE}"; export PROJECT_LANGUAGE;

BASH_OPTIONS="-e"

# print help message
function help() {
    if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/help.sh" ]]; then
        # run script by different language
        bash $BASH_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/help.sh
    fi

    # if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/.travis.yml" ]]; then
    #     echo ""
    #     echo "**************************************************"
    #     echo "* example .travis.yml file for $PROJECT_LANGUAGE *"
    #     echo "**************************************************"
    #     echo ""
    #     cat "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/.travis.yml"
    # fi
}

# verify environment variables
function verify_vars() {
    if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/verify_vars.sh" ]]; then
        # run script by different language
        bash $BASH_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/verify_vars.sh
    fi
}

if [[ "$TRAVIS_EXT_VERBOSE" = "true" ]]; then
    BASH_OPTIONS="-ex"  # set 'x' to print all shell scripts
fi

if [[ "$PROJECT_LANGUAGE" = "" ]]; then
    echo "Not setted 'PROJECT_LANGUAGE'"
    exit 1
else
    # verify environment variables by different language
    verify_vars
fi

function call_command() {
    local COMMAND="$1"

    if [[ "$COMMAND" = "" ]]; then
        # print help message if no command
        help
        exit 1
    fi

    if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh" ]]; then
        # run script by different language
        bash $BASH_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh
    elif [[ -f "$TRAVIS_EXT_HOME/share/$COMMAND.sh" ]]; then
        # run script shared with all languages
        bash $BASH_OPTIONS $TRAVIS_EXT_HOME/share/$COMMAND.sh
    else
        echo "Not supported command: $COMMAND"
        help
        exit 1
    fi
}

export -f call_command

# echo "set vars..."
source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

call_command $1

echo "finished."
