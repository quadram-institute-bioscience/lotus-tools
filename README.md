# Lotus Tools
FOSS utilities used by Lotus 16S Suite

[![Build Status](https://travis-ci.org/quadram-institute-bioscience/lotus-tools.svg?branch=master)](https://travis-ci.org/quadram-institute-bioscience/lotus-tools)

## Programs

Utilities developed by Falk Hildebrand and written in C++:

* **sdm** (Simple Demultiplexer, a fast tool for reads manupulation, [link](https://github.com/hildebra/sdm))
* **LCA** (least common ancestor evaluation given tax database, [link](https://github.com/hildebra/LCA))
* **rtk** (rarefaction toolkit v. 2.0, [link](https://github.com/hildebra/Rtk2))

## About this repository

The **scripts** directory contains the build script used to test the compilation of the utilities, 
and it's runned by *Travis-CI* inside a Ubuntu 18.04 Docker container.

Testing is performed using _.travis.yml_ configuration file (see [build history](https://travis-ci.org/quadram-institute-bioscience/lotus-tools/builds)).

### Installer (scripts/make_all.sh)

This scripts build the submodules (sdm, LCA, rtk) and additionally attempts the installation of:

* [swarm](https://github.com/torognes/swarm)
* [fasttree](https://wiki.gacrc.uga.edu/wiki/Fasttree)
* [infernal](http://eddylab.org/infernal/)
* [VSEARCH](https://github.com/torognes/vsearch)
