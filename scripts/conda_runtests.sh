#!/bin/bash
set -e
#set -ev  # exit on first error, print each command

# Replace dep1 dep2 ... with your dependencies
# conda create -q -n test-environment python=${PYTHON_VERSION} dep1 dep2 ...
#test_env=test-py${PYTHON_VERSION}
#conda env remove -n ${test_env} -y || true
#conda create -q -n ${test_env} python=${PYTHON_VERSION}
#source activate ${test_env}

# Add channels
#conda config --add channels conda-forge

echo "Installing abipy from conda-forge channel ..."
conda install abipy -c conda-forge

# Install abinit and abipy from conda channels.
#echo "Installing abinit from abinit channel ..."
#conda install abinit -c abinit
#abinit --version
#abinit --build

# Test Abipy scripts
abidoc.py man ecut
abirun.py --help
abicheck.py --help
abicheck.py --with-flow

######################################################
# Test abipy/develop with pymatgen installed via conda
######################################################
#conda uninstall abipy
#git clone https://github.com/abinit/abipy.git
#cd abipy && git checkout develop
#conda install -y --file ./requirements.txt
#conda install -y --file ./requirements-optional.txt

# Create configuration files.
#mkdir -p ${HOME}/.abinit/abipy
#cp abipy/data/managers/travis_scheduler.yml ${HOME}/.abinit/abipy/scheduler.yml
#cp abipy/data/managers/travis_manager.yml ${HOME}/.abinit/abipy/manager.yml

#python setup.py install --record installed_files.txt && cd ../

# Test Abipy scripts
#abidoc.py man ecut
#abirun.py --help
#abicheck.py --with-flow

#################################################
# Test abipy/master (stable) with pymatgen/master
#################################################
#conda uninstall pymatgen
#cat abipy/installed_files.txt | xargs rm -rf

#git clone https://github.com/materialsproject/pymatgen.git
#cd pymatgen && git checkout master
#pip install -q -r requirements.txt && pip install -q -r requirements-optional.txt
#python setup.py install --record installed_files.txt && cd ../

#cd abipy && git checkout master
#pip install -q -r requirements.txt && pip install -q -r requirements-optional.txt
#python setup.py install --record installed_files.txt && cd ../

# Test Abipy scripts
#abidoc.py man ecut
#abirun.py --help
#abicheck.py
#abicheck.py --with-flow

#########################################
# Test abipy/develop with pymatgen/master
#########################################
#cat abipy/installed_files.txt | xargs rm -rf
#cd abipy && git checkout develop
#pip install -q -r requirements.txt && pip install -q -r requirements-optional.txt
#python setup.py install --record installed_files.txt && cd ../

# Test Abipy scripts
#abidoc.py man ecut
#abirun.py --help
#abicheck.py
#abicheck.py --with-flow

# Deactivate environment.
#source deactivate ${test_env}
#conda env remove -n ${test_env} -y
