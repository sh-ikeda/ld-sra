#!/bin/sh
#$ -S /bin/sh
set -eux

# Load rbenv
export PATH="${HOME}/.rbenv/bin:${PATH}"
eval "$(rbenv init -)"

# ARGS
EXP_XML_PATH=${1}
ACC=$(basename ${EXP_XML_PATH} .experiment.xml)

# Path to directories
SH_DIR=$(cd $(dirname ${0}) && pwd -P)
DEST_DIR="${SH_DIR}/../data/${ACC:0:6}/${ACC}"
ttl_path="${DEST_DIR}/${ACC}.experiment.ttl"

# run xml2ttl
if [[ ! -e "${ttl_path}" ]]; then
  mkdir -p ${DEST_DIR}
  cd ${SH_DIR}/.. && ./xml2ttl experiment ${EXP_XML_PATH} |\
    | grep -v "^@prefix" > "${ttl_path}"
fi
