#!/bin/bash

DOMAIN=$1
DESTINATION_DIR=$2
OWNER=$3
GROUP=$4
MODE=$5

EXIT_CODE_NORMAL=0
EXIT_CODE_ERROR=1

funtcion error_message
{
    echo "$1" 1>&2
}

if [[ $# == 0 ]]
    local script_name=$(basename $0)
    echo "Usage: $script_name DOMAIN DESTINATION_DIR OWNER GROUP MODE"
    exit $EXIT_CODE_ERROR
fi

if [[ $RENEWED_DOMAINS =~ (^|[[:space:]])$DOMAIN([[:space:]]|$) ]]
then
    pushd $DESTINATION_DIR
    if [[ ! $? ]]
    then
        error_message "Error: can't enter to directory $DESTINATION_DIR"
        exit $EXIT_CODE_ERROR;
    fi
    for i in cert chain fullchain privkey
    do
        local current_name=$i.pem
	local real_name=$(realpath "$RENEWED_LINEAGE/$current_name")
        if [[ ! -r $real_name ]]
        then
            error_message "File $real_name doesn't exists"
            exit $EXIT_CODE_ERROR
        fi
        install --owner="$OWNER" --group="$GROUP" --mode="$MODE" --preserve-timestamps "$real_name" "$current_name"
    done
    popd
fi

