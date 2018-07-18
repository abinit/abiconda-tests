#!/bin/bash
#set -e
set -ev  # exit on first error, print each command

which pip
pip --version
pip install -U pip setuptools
pip --version
pip check

apt-get install libhdf5-dev libnetcdf-dev netcdf-bin

pip install six
#pip install pymatgen==2018.6.11
pip install abipy 
pip check

abidoc.py man ecut
abirun.py --help
abicheck.py --help