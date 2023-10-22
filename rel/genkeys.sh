#!/bin/sh
cd -P -- "$(dirname -- "$0")"
exec ./urepo eval "Urepo.CLI.genkeys([])"