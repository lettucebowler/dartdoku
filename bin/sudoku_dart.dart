import 'dart:core';
import 'domains/sudoku/SudokuProblem.dart';
import 'domains/sudoku/SudokuState.dart';
import 'framework/problem/SolvingAssistant.dart';

SudokuProblem problem;
SolvingAssistant assistant;
int board_size;
int cell_size;

void doMove(int num, int row, int col) {
  if (!problem.success()) {
    var move = 'Place ' +
        num.toString() +
        ' at ' +
        row.toString() +
        ' ' +
        col.toString();
    assistant.tryMove(move);
  }
}

void solveGame() {
  for (var i = 0; i < board_size; i++) {
    for (var j = 0; j < board_size; j++) {
      for (var k = 1; k <= board_size; k++) {
        if (!problem.isCorrect(i, j)) {
          doMove(k, i, j);
          if (problem.isCorrect(i, j)) {
            break;
          }
        }
      }
    }
  }
}

void main(List<String> arguments) {
  // var sudoku = Sudoku.withMoreHints(0);
  problem = SudokuProblem();
  assistant = SolvingAssistant(problem);
  cell_size = problem.cell_size;
  board_size = problem.board_size;
  SudokuState current_state = problem.getCurrentState();
  print(problem.getStateAsString(current_state));
  solveGame();

  if (problem.success()) {
    print('Solved!');
    print(problem.getStateAsString(problem.getCurrentState()));
  }
}
