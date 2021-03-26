//public packages
import 'dart:core';

//My stuff
import 'domains/sudoku/SudokuProblem.dart';

String help =
    'Usage: sudoku [OPTION]...\nA simple dart program to generate and display a sudoku game.\n\n  -h, --help          Display this message\n  -i, --initialHints  number of givens on starting board, defaulting to 30';

List<SudokuProblem> getProblems(int hints, int count) {
  var problems = <SudokuProblem>[];
  for (var i = 0; i < count; i++) {
    var problem = SudokuProblem.withMoreHints(hints);
    problems.add(problem);
  }
  return problems;
}

SudokuProblem getProblem(int hints) {
  return SudokuProblem.withMoreHints(hints);
}
