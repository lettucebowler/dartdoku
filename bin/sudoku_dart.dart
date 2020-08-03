import 'dart:core';
import 'domains/sudoku/SudokuProblem.dart';
import 'domains/sudoku/SudokuState.dart';

void main(List<String> arguments) {
  // var sudoku = Sudoku.withMoreHints(0);
  var problem = SudokuProblem();
  SudokuState initial_state = problem.getInitialState();
  print(problem.getStateAsString(initial_state));
}
