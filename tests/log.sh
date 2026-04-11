#!/bin/bash

VAR_LEVEL=DEBUG

source $HOME/.local/ash/a.sh

echo "Starting $0"
echo "  LEVEL=${VAR_LEVEL}"
echo ""

ash new log "TEST" -l "${VAR_LEVEL}"

TEST_trace "main" "Logging TRACE"
TEST_debug "main" "Logging DEBUG"
TEST_info "main" "Logging INFO"
TEST_warn "main" "Logging WARN"
TEST_error "main" "Logging ERROR"
