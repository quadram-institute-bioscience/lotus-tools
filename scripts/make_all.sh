#!/bin/sh
set -euxo pipefail
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
bin_dir="$script_dir/../bin";

mkdir -p "$bin_dir"

for TOOL in rtk sdm LCA;
do
	cd "$script_dir/../$TOOL"
	make
	mv "$TOOL" "$bin_dir"
done


