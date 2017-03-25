#!/bin/bash
set -ev  # exit on first error, print each command

which pip
pip --version
pip install --upgrade pip
pip --version
pip check

pip install six
pip install abipy 
#pip install ipython
pip check

abidoc.py man ecut
abirun.py --help
abicheck --help