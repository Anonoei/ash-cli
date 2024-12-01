#!/bin/bash
# ASH CLI

ASH_VERSION="0.3.3"
ASH_CONFIG="${HOME}/.config/ash"
ASH_EXTRAS=()

function ash_config_read {
    (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-;
}

function ash_config_get {
    val="$(ash_config_read $ASH_CONFIG/ash.conf "${1}")";
    if [ "${val}" = "__UNDEFINED__" ]; then
        val="$(ash_config_read ash.conf.defaults "${1}")";
    fi
    printf -- "%s" "${val}";
}

ASH_ROOT="$(ash_config_get "PATH_ROOT" | sed 's/~/$HOME/g')"
ASH_ROOT="$(eval echo $ASH_ROOT)"

if [[ "$ASH_ROOT" == "__UNDEFINED__" ]] ; then
    echo "Failed to get PATH_ROOT"
    return
fi

if [[ ! -d "$ASH_ROOT" ]]; then
    echo "Failed to find ASH src!"
    return
fi

mkdir -p $ASH_CONFIG/plugins

source $ASH_ROOT/ash.d/escape
source $ASH_ROOT/logger "ASH" -l "INFO"


source $ASH_ROOT/ash.d/fmt
source $ASH_ROOT/ash.d/install

ASH_trace "a.sh" "Initialized!"

function ash {
    source $ASH_ROOT/ash.d/main $*
}
