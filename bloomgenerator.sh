#!/bin/sh

FILE_NAME="/bloom_data/addrs_${1}.txt"
FILE_SIZE=$(wc -l ${FILE_NAME})
/src/bloomgenerator/bloomgenerator "${FILE_SIZE}" "${FILE_NAME}" "/bloom_data/bloom_data.${1}"