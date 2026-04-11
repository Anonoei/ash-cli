#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

VAR_FILE="${SCRIPT_DIR}/test.conf"
VAR_DEFAULT="${SCRIPT_DIR}/test.conf.default"

source $HOME/.local/ash/a.sh

echo "Starting $0"
echo "  FILE=${VAR_FILE}"
echo "  DEFAULT=${VAR_FILE}"
echo ""

ash new config "TEST" -f "${VAR_FILE}" -d "${VAR_DEFAULT}"

IN_BOTH=$(TEST_get "IN_BOTH")
echo "Read config IN_BOTH: '${IN_BOTH}'"

ONLY_IN_CONFIG=$(TEST_get "ONLY_IN_CONFIG")
echo "Read config ONLY_IN_CONFIG: '${ONLY_IN_CONFIG}'"

ONLY_IN_DEFAULT=$(TEST_get "ONLY_IN_DEFAULT")
echo "Read config ONLY_IN_DEFAULT: '${ONLY_IN_DEFAULT}'"

MISSING=$(TEST_get "MISSING")
echo "Read config MISSING: '${MISSING}'"

TEST_set "MISSING" "NO MORE"
echo "Set config MISSING"

MISSING=$(TEST_get "MISSING")
echo "Read config MISSING: '${MISSING}'"

TEST_set "MISSING" "NO LONGER"
echo "Set config MISSING"

MISSING=$(TEST_get "MISSING")
echo "Read config MISSING: '${MISSING}'"

TEST_del "MISSING"
echo "Deleting config MISSING"

MISSING=$(TEST_get "MISSING")
echo "Read config MISSING: '${MISSING}'"
