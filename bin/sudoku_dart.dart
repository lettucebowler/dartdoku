import 'dart:core';
import 'domains/sudoku/SudokuProblem.dart';
import 'domains/sudoku/SudokuState.dart';
import 'framework/problem/SolvingAssistant.dart';

SudokuProblem problem;
SolvingAssistant assistant;
int board_size;
int cell_size;

void main(List<String> arguments) {
  // var sudoku = Sudoku.withMoreHints(0);
  problem = SudokuProblem.withMoreHints(13);

  SudokuState current_state = problem.getCurrentState();
  print('Initial Board:');
  print(problem.getStateAsString(current_state));
  print('Solution:');
  print(problem.getStateAsString(problem.getFinalState()));
}
