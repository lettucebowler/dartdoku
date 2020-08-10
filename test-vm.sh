#!/bin/bash
for f in {1..50}
do
    time dart bin/sudoku_dart.dart >> /dev/null
done
