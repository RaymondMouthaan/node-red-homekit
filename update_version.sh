#!/bin/bash
cat ./package.json

export NODE_RED_VERSION=`grep -Eo "\"node-red\": \"(\w*.\w*.\w*)" package.json | cut -d\" -f4`
echo "node-red version: ${NODE_RED_VERSION}"
sed "s/\(version\": \"\).*\(\"\)/\1$NODE_RED_VERSION\"/g" package.json > tmpfile && mv tmpfile package.json

export NODE_RED_HOMEKIT_VERSION=`grep -Eo "\"node-red-contrib-homekit-bridged\": \"\^(\w*.\w*.\w*)" package.json | cut -d"^" -f2`
echo "node-red-contrib-homekit-bridged version: ${NODE_RED_HOMEKIT_VERSION}"

cat ./package.json
