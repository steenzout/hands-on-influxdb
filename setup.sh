#!/bin/bash

source environment

curl -G ${API}/query --data-urlencode "q=CREATE DATABASE ${DB}"
