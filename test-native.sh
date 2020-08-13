#!/bin/bash
mkdir build
dart2native bin/sudoku_dart.dart -o build/sudoku
for f in {1..50}
do
    time build/sudoku >> /dev/null
done
