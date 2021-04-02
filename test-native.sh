#!/bin/bash
./compile.sh
for f in {1..50}
do
    time build/dartdoku >> /dev/null
done
