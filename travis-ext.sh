#!/bin/bash -e

# public vars for all languages
export PROJECT_DIR="${PROJECT_DIR-$TRAVIS_BUILD_DIR}"

# private vars
TRAVIS_EXT_HOME="${TRAVIS_EXT_HOME-${HOME}/travis-ext}"
# TRAVIS_EXT_OPTIONS="x"  # set 'x' to print all shell scripts

COMMAND="$1"

# print help message
function help
{
    if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/help.sh" ]]; then
        # run script by different language
        bash -e$TRAVIS_EXT_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/help.sh
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
function verify_vars
{
    if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/verify_vars.sh" ]]; then
        # run script by different language
        bash -e$TRAVIS_EXT_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/verify_vars.sh
    fi
}

if [[ "$TRAVIS_EXT_HOME" = "" ]]; then
    echo "Not setted 'TRAVIS_EXT_HOME'"
    exit 1
fi

if [[ "$PROJECT_LANGUAGE" = "" ]]; then
    echo "Not setted 'PROJECT_LANGUAGE'"
    exit 1
else
    # verify environment variables by different language
    verify_vars
fi

if [[ "$COMMAND" = "" ]]; then
    # print help message if no command
    help
    exit 1
fi

if [[ -f "$TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh" ]]; then
    # run script by different language
    bash -e$TRAVIS_EXT_OPTIONS $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/$COMMAND.sh
elif [[ -f "$TRAVIS_EXT_HOME/share/$COMMAND.sh" ]]; then
    # run script shared with all languages
    bash -e$TRAVIS_EXT_OPTIONS $TRAVIS_EXT_HOME/share/$COMMAND.sh
else
    echo "Not supported command: $COMMAND"
    help
    exit 1
fi