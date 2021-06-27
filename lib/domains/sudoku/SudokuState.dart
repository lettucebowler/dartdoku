import 'dart:core';

/*
 * This class represents states of various tile-moving puzzle problems,
 * including the 8-Puzzle, which involves a 3x3 display area. It can also
 * represent other displays of different dimensions, e.g. 4x4. A puzzle state is
 * represented with a 2D array of integers.
 *
 */
class SudokuState {
  /*
     * A 2D integer array represents the sudoku board.
     */
  List<List<int>> board = getEmptyBoard(9);

  // A puzzle state constructor that accepts a 2D 9x9 array of integers.
  // @param tiles a 2d array of integers
  SudokuState(List<List<int>> board) {
    this.board = board;
  }

  SudokuState.fromString(boardString) {
    if (board.length == 81) {
      for (var i = 0; i < board.length; i++) {
        board[i ~/ 9].add(int.parse(boardString[i]));
      }
    }
  }

  static List<List<int>> getEmptyBoard(int boardSize) {
    var board = List<List<int>>.generate(
        boardSize, (i) => List<int>.filled(9, 0, growable: false));
    return board;
  }

  SudokuState applyMove(int num, int row, int col) {
    board[row][col] = num;
    return this;
  }

  // Tests for equality of this puzzle state with another.
  // @param o the other state
  // @return true if the underlying arrays are equal, false otherwise
  bool equals(Object? o) {
    if (o == null) {
      return false;
    }
    if (o.runtimeType != SudokuState) {
      return false;
    }
    var other = o as SudokuState;
    if (this == other) {
      return true;
    }
    var equal = true;
    for (var i = 0; i < board.length; i++) {
      for (var j = 0; j < board.length; j++) {
        if (board[i][j] != other.board[i][j]) {
          equal = false;
        }
      }
    }
    return equal;
  }
}
