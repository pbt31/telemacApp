### TELEMAC settings -----------------------------------------------------------
###
# Path to telemac root dir
export HOMETEL=$TELEMAC_DIR/app
# Adding python scripts to PATH
export PATH=$HOMETEL/scripts/python27:.:$PATH
# Configuration file
export SYSTELCFG=$HOMETEL/configs/systel.cfg
# Name of the configuration to use
export USETELCFG=$BUILD_CONFIG
# Path to this file
export SOURCEFILE=$HOMETEL/configs/pysource.sh
### Python
# To force python to flush its output
export PYTHONUNBUFFERED='true'
### API
export PYTHONPATH=$HOMETEL/scripts/python27:$PYTHONPATH
export LD_LIBRARY_PATH=$HOMETEL/builds/$USETELCFG/wrap_api/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$HOMETEL/builds/$USETELCFG/wrap_api/lib:$PYTHONPATH
###
### EXTERNAL LIBRARIES -----------------------------------------------------------
###
### METIS -------------------------------------------------------------
export METISHOME=$TELEMAC_DIR/$DEP/metis/
