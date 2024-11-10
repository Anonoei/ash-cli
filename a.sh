#!/bin/bash
# ASH CLI

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

function ash {
    export ASH_VERSION="0.3.1"

    export ASH_CONFIG="${HOME}/.config/ash"

    export ASH_ROOT="$(ash_config_get "PATH_ROOT" | sed 's/~/$HOME/g')"
    export ASH_ROOT="$(eval echo $ASH_ROOT)"

    #export ASH_PLUGS=($(ash_config_get "PLUGINS"))

    if [[ ! -d "$ASH_ROOT" ]]; then
        echo "Failed to find ASH src!"
        exit 1
    fi

    source $ASH_ROOT/ash.d/main

    mkdir -p $ASH_CONFIG/plugins

    echo "ASH:"
    echo " ASH_VERSION: $ASH_VERSION"
    echo " ASH_ROOT: $ASH_ROOT"
    echo " ASH_PLUGS: (${ASH_PLUGS[@]})"

    _ash $*
}
