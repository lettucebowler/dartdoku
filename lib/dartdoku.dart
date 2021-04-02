import 'dart:core';
import 'package:pedantic/pedantic.dart';
import 'domains/sudoku/SudokuProblem.dart';

String help =
    'Usage: sudoku [OPTION]...\nA simple dart program to generate and display a sudoku game.\n\n  -h, --help          Display this message\n  -i, --initialHints  number of givens on starting board, defaulting to 30';

Future<List<SudokuProblem>> getProblems(int hints, int count) async {
  var problems = <SudokuProblem>[];
  for (var i = 0; i < count; i++) {
    unawaited(getProblem(hints).then((p) {
      problems.add(p);
    }));
  }
  return problems;
}

Future<SudokuProblem> getProblem(int hints) async {
  return SudokuProblem.withMoreHints(hints);
}
