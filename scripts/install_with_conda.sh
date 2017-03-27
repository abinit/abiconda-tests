#!/bin/bash
#set -e
set -ev  # exit on first error, print each command

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

# Install from conda channels.
conda install abinit
conda install abipy

# Test Abipy scripts
abidoc.py man ecut
abirun.py --help
abicheck.py --help
#abicheck.py --with-flow

# Test abipy/develop with pymatgen installed from conda.
conda uninstall abipy
git clone https://github.com/abinit/abipy.git 
cd abipy && git checkout develop
conda install -y --file ./requirements-optional.txt
conda install -y --file ./requirements.txt
python setup.py install --record installed_files.txt && cd ../

# Test Abipy scripts
abidoc.py man ecut
abirun.py --help
abicheck.py --help
#abicheck.py --with-flow

# Test pymatgen/master with abipy/master
conda uninstall pymatgen
cat abipy/installed_files.txt | xargs rm -rf
#conda uninstall abipy

git clone https://github.com/materialsproject/pymatgen.git
cd pymatgen && git checkout master
#conda install -y --file ./requirements.txt
#conda install -y --file ./requirements-optional.txt
pip install -q -r requirements.txt && pip install -q -r requirements-optional.txt 
python setup.py install --record installed_files.txt && cd ../

cd abipy && git checkout master
pip install -q -r requirements.txt && pip install -q -r requirements-optional.txt 
#conda install -y --file ./requirements.txt
#conda install -y --file ./requirements-optional.txt
python setup.py install --record installed_files.txt && cd ../

# Test Abipy scripts
abidoc.py man ecut
abirun.py --help
abicheck.py --help
#abicheck.py --with-flow

# Deactivate environment.
source deactivate ${test_env}
conda env remove -n ${test_env} -y

#- git clone https://github.com/gmatteo/pymatgen.git && cd pymatgen && pip install -q -r requirements.txt && pip install -q -r requirements-optional.txt && python setup.py install && cd ../
# pymatgen master
#- git clone https://github.com/materialsproject/pymatgen.git && cd pymatgen && 
#pip install -q -r requirements.txt && pip install -q -r requirements-optional.txt && python setup.py install