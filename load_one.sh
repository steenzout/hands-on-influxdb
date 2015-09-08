#!/bin/bash

source environment

curl -i -XPOST "${API}/write?db=${DB}" --data-binary "${1}"
