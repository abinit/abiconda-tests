#!/bin/bash
set -e
#set -ev  # exit on first error, print each command

# Replace dep1 dep2 ... with your dependencies
# conda create -q -n test-environment python=${PYTHON_VERSION} dep1 dep2 ...
test_env=test-py${PYTHON_VERSION}
conda env remove -n ${test_env} -y || true
conda create -q -n ${test_env} python=${PYTHON_VERSION}
source activate ${test_env}

# Add channels
conda config --add channels conda-forge
conda config --add channels matsci
conda config --add channels abinit
#conda config --add channels gmatteo

# Install
conda install abinit
conda install abipy

# Test
abidoc.py man ecut
abirun.py --help
abicheck.py --help
source deactivate ${test_env}
conda env remove -n ${test_env} -y