#!/bin/bash
# ASH CLI

if [[ ! -z $ASH_VERSION ]]; then
    return
fi

ASH_VERSION="0.4.0"
ASH_CONFIG="${HOME}/.config/ash"
ASH_EXTRAS=()

ASH_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source $ASH_ROOT/ash.d/escape
source $ASH_ROOT/ash.d/fmt
source $ASH_ROOT/ash.d/install

source $ASH_ROOT/utils.d/config new "ASH" -f "$ASH_CONFIG/ash.conf" -d "$ASH_ROOT/ash.conf.defaults"
source $ASH_ROOT/utils.d/log new "ASH" -l "INFO"

ASH_PKGMAN=$(bash $ASH_ROOT/extras.d/pkg.d/pkgman)
mkdir -p $ASH_CONFIG/plugins

ASH_trace "a.sh" "Initialized!"

function ash {
    source $ASH_ROOT/ash.d/main $*
}
