import 'package:sudoku_dart/sudoku_dart.dart' as sudoku_dart;
import 'dart:core';
import 'domains/sudoku/Sudoku.dart';

void main(List<String> arguments) {
  var sudoku = Sudoku.withMoreHints(0);
  print(sudoku.toString());
}
