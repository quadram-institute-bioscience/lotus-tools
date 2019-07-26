#!/bin/sh

set -euxo pipefail
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
bin_dir="$script_dir/../bin";

mkdir -p "$bin_dir"

# COMPILE HILDEOME
for TOOL in rtk sdm LCA;
do
	cd "$script_dir/../$TOOL"
	cp -v "$script_dir/$TOOL.makefile" "Makefile"
	make clean
	make
	mv "$TOOL" "$bin_dir"
	rm *.o

done

# If a parameter [future: --skip] is specified, avoid installing external tools
if [ -z ${1+x} ]; 
then 
    echo "Downloading and installing swarm, fasttree, vsearch, infernal [--skip to avoid]"; 
else 
    echo "Quitting."; 
    exit 0;
fi

# GET SWARM
cd "$script_dir/.."
git clone https://github.com/torognes/swarm
cd swarm
make
mv ./bin/swarm "$bin_dir"

# FASTTREE BINARY
wget -O "$bin_dir/fasttree" "http://www.microbesonline.org/fasttree/FastTree"

# VSEARCH
cd "$script_dir"
wget "https://github.com/torognes/vsearch/archive/v2.13.4.tar.gz"
tar xzf "v2.13.4.tar.gz"
cd "vsearch-2.13.4"
./autogen.sh
./configure
make
make install
#/lotus-tools/scripts/vsearch-2.13.4/bin/vsearch;
mv ./bin/vsearch "$bin_dir"


# INFERNAL
cd "$script_dir"
wget http://eddylab.org/infernal/infernal-1.1.2-linux-intel-gcc.tar.gz
tar xfz infernal-1.1.2-linux-intel-gcc.tar.gz
cd infernal-1.1.2-linux-intel-gcc
./configure
make
make check
make install
#/lotus-tools/scripts/vsearch-2.13.4/bin/vsearch; /lotus-tools/scripts/infernal-1.1.2-linux-intel-gcc/binaries/
mv  /lotus-tools/scripts/infernal-1.1.2-linux-intel-gcc/binaries/* "$bin_dir"
