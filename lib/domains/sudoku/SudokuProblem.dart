import 'dart:math';
import 'Sudoku.dart';
import 'SudokuState.dart';

class SudokuProblem {
  int cellSize = 3;
  int boardSize = 9;
  late SudokuState initialState;
  late SudokuState currentState;
  late SudokuState finalState;

  SudokuProblem() {
    var sudoku = Sudoku();
    initialState = SudokuState(sudoku.initialBoard);
    currentState = initialState;
    finalState = SudokuState(sudoku.finalBoard);
  }

  SudokuProblem.withMoreHints(int hints) {
    var sudoku = Sudoku();
    print(sudoku.initialBoard);
    initialState = SudokuState(sudoku.initialBoard);
    currentState = initialState;
    finalState = SudokuState(sudoku.finalBoard);
    addClues(hints - 17);
  }

  SudokuProblem.fromJSON(Map<String, dynamic> json) {
    initialState = SudokuState.fromString(json['initial board']);
    currentState = initialState;
    finalState = SudokuState.fromString(json['final board']);
  }

  SudokuProblem.fromBoards(List<List<int>> initialBoard,
      List<List<int>> currentBoard, List<List<int>> finalBoard) {
    initialState = SudokuState(initialBoard);
    currentState = SudokuState(currentBoard);
    finalState = SudokuState(finalBoard);
  }

  SudokuProblem.fromStates(SudokuState initialState, SudokuState currentState,
      SudokuState finalState) {
    this.initialState = initialState;
    this.currentState = currentState;
    this.finalState = finalState;
  }

  void addClues(int hintOffset) {
    if (initialState.equals(currentState)) {
      if (hintOffset >= 0 && hintOffset <= 64) {
        var random = Random();
        var pos1;
        var pos2;
        var initialBoard = initialState.board;
        var finalBoard = finalState.board;
        for (var i = 0; i < hintOffset; i++) {
          do {
            pos1 = random.nextInt(boardSize);
            pos2 = random.nextInt(boardSize);
          } while (initialBoard[pos1][pos2] != 0);
          initialBoard[pos1][pos2] = finalBoard[pos1][pos2];
        }

        initialState = SudokuState(initialBoard);
        currentState = initialState;
      } else {
        throw ArgumentError('Hint offset not in inclusive range 0..64');
      }
    } else {
      throw Exception(
          'This method should only be used on an unplayed problem to increase the initial hints.');
    }
  }

  void reset() {
    currentState = initialState;
  }

  void solve() {
    currentState = finalState;
  }

  bool applyMove(int num, int row, int col) {
    currentState = currentState.applyMove(num, row, col);
    var isLegalMove = isLegal(row, col);
    return isLegalMove;
  }

  bool isInitialHint(int row, int col) {
    return (initialState.board[row][col] != 0);
  }

  bool isCorrect(int row, int col) {
    var currentBoard = currentState.board;
    var finalBoard = finalState.board;
    return (currentBoard[row][col] == finalBoard[row][col]);
  }

  bool isLegal(int row, int col) {
    return !(_checkRowForDuplicates(row, col) ||
        _checkColForDuplicates(row, col) ||
        _checkBlockForDuplicates(row, col));
  }

  bool _checkRowForDuplicates(int row, int col) {
    var currentTiles = currentState.board;
    var count = 0;
    for (var i = 0; i < boardSize; i++) {
      if (currentTiles[row][i] == currentTiles[row][col]) {
        count++;
      }
    }
    return count > 1;
  }

  bool _checkColForDuplicates(int row, int col) {
    var currentTiles = currentState.board;
    var count = 0;
    for (var i = 0; i < boardSize; i++) {
      if (currentTiles[i][col] == currentTiles[row][col]) {
        count++;
      }
    }
    return count > 1;
  }

  bool _checkBlockForDuplicates(int row, int col) {
    var currentTiles = currentState.board;
    var count = 0;
    var startRow = row ~/ cellSize * cellSize;
    var startCol = col ~/ cellSize * cellSize;
    for (var i = 0; i < cellSize; i++) {
      for (var j = 0; j < cellSize; j++) {
        if (currentTiles[startRow + i][startCol + j] ==
            currentTiles[row][col]) {
          count++;
        }
      }
    }
    return count > 1;
  }

  bool checkRowCompletion(int row) {
    var complete = true;
    var currentTiles = currentState.board;
    var finalTiles = finalState.board;
    for (var i = 0; i < currentTiles.length; i++) {
      if (currentTiles[row][i] != finalTiles[row][i]) {
        complete = false;
        break;
      }
    }
    return complete;
  }

  bool checkColCompletion(int col) {
    var complete = true;
    var currentTiles = currentState.board;
    var finalTiles = finalState.board;
    for (var i = 0; i < currentTiles.length; i++) {
      if (currentTiles[i][col] != finalTiles[i][col]) {
        complete = false;
        break;
      }
    }
    return complete;
  }

  bool checkBlockCompletion(int row, int col) {
    var complete = true;
    var currentTiles = currentState.board;
    var finalTiles = finalState.board;
    var startRow = row ~/ cellSize * cellSize;
    var startCol = col ~/ cellSize * cellSize;
    for (var i = 0; i < cellSize; i++) {
      for (var j = 0; j < cellSize; j++) {
        if (currentTiles[startRow + i][startCol + j] !=
            finalTiles[startRow + i][startCol + j]) {
          complete = false;
        }
      }
    }
    return complete;
  }

  static String stateToString(SudokuState state) {
    return Sudoku.boardToString(state.board);
  }

  static String boardToString(SudokuState state) {
    var board = state.board;
    var string = '';
    for (var i = 0; i < board.length; i++) {
      for (var j = 0; j < (board[i]).length; j++) {
        // ignore: use_string_buffers
        string += board[i][j].toString();
      }
    }
    return string;
  }

  bool success() {
    return currentState.equals(finalState);
  }
}
