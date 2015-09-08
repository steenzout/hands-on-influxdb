#!/bin/bash

./data.py A B C D E F G H I | xargs -I {} -P 4 bash load_one.sh {}
