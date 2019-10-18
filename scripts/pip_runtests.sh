#!/bin/bash
#set -e
set -ev  # exit on first error, print each command

which pip
pip --version
pip install -U pip setuptools
pip --version
pip check

sudo apt-get update
sudo apt-get install libhdf5-dev libnetcdf-dev netcdf-bin

echo "Installing abipy from abinit channel ..."
pip install abipy
# This will fails because pymatgen pins the reqs
#pip check

abidoc.py man ecut
abirun.py --help
abicheck.py --help
