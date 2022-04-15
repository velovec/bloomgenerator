#!/bin/sh

set -xe

FILE_NAME="/bloom_data/addrs_${1}.txt"
FILE_SIZE=$(wc -l ${FILE_NAME})
/src/bloomgenerator/bloomgenerator ${FILE_SIZE} "/bloom_data/bloom_data.${1}"

MD5=$(md5sum "/bloom_data/bloom_data.${1}")

echo "${MD5} ${FILE_SIZE}" > "/bloom_data/bloom_data.${1}.meta"

sleep 2