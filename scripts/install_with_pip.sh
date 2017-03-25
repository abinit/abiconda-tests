#!/bin/bash
set -ev  # exit on first error, print each command

which pip
pip --version

pip install abipy 
#pip install ipython

abidoc.py man ecut
abirun.py --help
abicheck --help