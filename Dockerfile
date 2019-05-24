FROM alpine

RUN apk add bash g++ make zlib-dev git && cd / && \
	git clone --recurse-submodules https://github.com/quadram-institute-bioscience/lotus-tools.git && \
	bash /lotus-tools/scripts/make_all.sh

ENV PATH=$PATH:/lotus-tools/bin/
