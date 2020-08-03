import 'package:sudoku_dart/sudoku_dart.dart' as sudoku_dart;
import 'dart:convert';
import 'dart:math';

class Sudoku {
  int board_size;
  int cell_size;
  int hint_offset;
  List initial_board;
  List final_board;

  Sudoku() {
    cell_size = 3;
    board_size = cell_size * cell_size;
    hint_offset = 0;
    initial_board =
        List.generate(board_size, (i) => List(board_size), growable: false);
    final_board =
        List.generate(board_size, (i) => List(board_size), growable: false);
    _generateFilled();
    _scrambleBoard();
    _preparePuzzle();
  }

  void _generateFilled() {
    int k;
    var n = 1;

    for (var i = 0; i < board_size; i++) {
      k = n;
      for (var j = 0; j < board_size; j++) {
        if (k > board_size) {
          k = 1;
        }

        final_board[i][j] = k;
        k++;
      }

      n = k + cell_size;
      if (k == board_size + 1) {
        n = 1 + cell_size;
      }

      if (n > board_size) {
        n = (n % board_size) + 1;
      }
    }
  }

  void _scrambleBoard() {
    var max_iterations = 15;
    _scrambleRows(max_iterations);
    _scrambleCols(max_iterations);
    _randomizeDigits();
  }

  void _randomizeDigits() {
    var digits = List(board_size);
    for (var i = 0; i < board_size; i++) {
      digits[i] = i + 1;
    }
    digits = _getRandomizedOrder(digits);
    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board_size; j++) {
        var temp = final_board[i][j];
        final_board[i][j] = digits[temp - 1];
      }
    }
  }

  void _preparePuzzle() {
    print('preparePuzzle');
    // initial_board = List(9)
    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board_size; j++) {
        initial_board[i][j] = final_board[i][j];
      }
    }
    var num_removed = 0;
    var max_remove;

    // Set max number of empty cells on a board
    if (cell_size == 2) {
      max_remove = 12 - hint_offset;
    } else if (cell_size == 3) {
      max_remove = 51 - hint_offset;
    } else if (cell_size == 4) {
      max_remove = 150 - hint_offset;
    } else {
      max_remove = 0;
    }

    //create a list of valid positions, removed cell must be in list
    var valid_positions = [];
    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board_size; j++) {
        valid_positions.add([i, j]);
      }
    }

    var rand_pos;
    var temp;
    var row;
    var col;
    var current_board =
        List.generate(board_size, (i) => List(board_size), growable: false);
    do {
      for (var i = 0; i < board_size; i++) {
        for (var j = 0; j < board_size; j++) {
          current_board[i][j] = initial_board[i][j];
        }
      }
      rand_pos = _getRandom(valid_positions.length);
      var tmp_pos = valid_positions[rand_pos];
      row = tmp_pos[0];
      col = tmp_pos[1];
      temp = current_board[row][col];
      current_board[row][col] = 0;
      var solution_count = _countSolutions(0, 0, current_board, 0);

      if (solution_count > 1) {
        print('solution_count: ' + solution_count.toString());
        current_board[row][col] = temp;
      } else {
        num_removed++;
        valid_positions.remove(rand_pos);
      }
    } while (num_removed < max_remove);

    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board_size; j++) {
        initial_board[i][j] = current_board[i][j];
      }
    }
    print(num_removed.toString());
  }

  int _countSolutions(int i, int j, List board, int count) {
    if (i == board.length) {
      i = 0;
      if (++j == board.length) {
        return count;
      }
    }
    if (board[i][j] != 0) {
      // Skip filled cells
      return _countSolutions(i + 1, j, board, count);
    }
    for (int val = 1; val <= board.length && count < 2; ++val) {
      if (_checkSafety(board, i, j, val)) {
        board[i][j] = val;
        count = _countSolutions(i + 1, j, board, count);
      }
    }
    board[i][j] = 0;
    return count;
  }

  bool _solve(int i, int j, List board) {
    var current_board =
        List.generate(board_size, (i) => List(board_size), growable: false);
    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board_size; j++) {
        current_board[i][j] = board[i][j];
      }
    }
    if (i == board_size) {
      i = 0;
      if (++j == board_size) {
        return true;
      }
    }
    if (current_board[i][j] != 0) {
      return _solve(i + 1, j, current_board);
    }
    for (var val = 1; val <= board_size; ++val) {
      if (_checkSafety(current_board, i, j, val)) {
        current_board[i][j] = val;
        if (_solve(i + 1, j, current_board)) {
          return true;
        }
        current_board[i][j] == 0;
      }
    }
    return false;
  }

  bool _checkSafety(List board, int row, int col, int val) {
    print('checkSafety');
    // Check row
    for (var d = 0; d < board.length; d++) {
      if (board[row][d] == num) {
        print('false');
        return false;
      }
    }
    // Check column
    for (var ints in board) {
      if (ints[col] == num) {
        print('false');
        return false;
      }
    }
    // Check block
    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board.length; j++) {
        var same_row_block = i ~/ cell_size == row ~/ cell_size;
        var same_col_block = j ~/ cell_size == col ~/ cell_size;
        if (same_row_block && same_col_block) {
          if (board[i][j] == num) {
            print('false');
            return false;
          }
        }
      }
    }
    // Passed all tests
    print('true');
    return true;
  }

  List<int> _getRandomizedOrder(List arr) {
    print('getRandomizedOrder');
    var r = Random();
    var array = List<int>.from(arr);
    for (var i = 0; i < array.length; i++) {
      var random_pos = r.nextInt(board_size);
      var temp = array[i];
      array[i] = array[random_pos];
      array[random_pos] = temp;
    }
    print(array);
    return array;
  }

  void _scrambleRows(int iterations) {
    for (var i = 0; i < board_size; i++) {
      // print(toString());
      var positions = _getPositionsToSwap();
      _swapRows(positions[0], positions[1]);
    }
  }

  void _scrambleCols(int iterations) {
    for (var i = 0; i < board_size; i++) {
      // print(toString());
      var positions = _getPositionsToSwap();
      _swapCols(positions[0], positions[1]);
    }
  }

  void _swapRows(int pos1, int pos2) {
    for (var i = 0; i < board_size; i++) {
      var temp = final_board[pos1][i];
      final_board[pos1][i] = final_board[pos2][i];
      final_board[pos2][i] = temp;
    }
  }

  void _swapCols(int pos1, int pos2) {
    for (var i = 0; i < board_size; i++) {
      var temp = final_board[i][pos1];
      final_board[i][pos1] = final_board[i][pos2];
      final_board[i][pos2] = temp;
    }
  }

  List<int> _getPositionsToSwap() {
    var pos1 = _getRandom(board_size);
    int pos2;
    do {
      pos2 = _getRandom(cell_size);
      pos2 = (pos1 ~/ cell_size) * cell_size + pos2;
    } while (pos1 ~/ cell_size != pos2 ~/ cell_size);
    return [pos1, pos2];
  }

  int _getRandom(int max) {
    var random = Random();
    return random.nextInt(max);
  }

  @override
  String toString() {
    var buffer = StringBuffer();
    buffer.write(_boardToString(final_board));
    buffer.write('\n');
    buffer.write(_boardToString(initial_board));
    return buffer.toString();
  }

  String _boardToString(List board) {
    var buffer = StringBuffer();
    var space = '';
    var divider = _makeDivider();
    for (var i = 0; i < cell_size; i++) {
      buffer.write(space);
      buffer.write(divider);
      space = '\n';
      for (var j = 0; j < cell_size; j++) {
        buffer.write(space);
        buffer.write(_rowToString(board[(i * cell_size + j) % board_size]));
      }
    }
    buffer.write(space + divider);
    return buffer.toString();
  }

  String _rowToString(List board) {
    var buffer = StringBuffer();
    var spacer = '';
    for (var i = 0; i < board_size; i++) {
      if (i % cell_size == 0) {
        spacer = '|';
      }

      buffer.write(spacer);
      var to_place = board[i] == 0 ? ' ' : board[i];
      buffer.write(to_place);
      spacer = ' ';
    }
    buffer.write('|');
    return buffer.toString();
  }

  String _makeDivider() {
    var buffer = StringBuffer();
    for (var i = 0; i < cell_size + 1; i++) {
      buffer.write('+');
      if (i < cell_size) {
        for (var j = 0; j < cell_size * 2 - 1; j++) {
          buffer.write('-');
        }
      }
    }
    return buffer.toString();
  }
}

void main(List<String> arguments) {
  var sudoku = Sudoku();
  print(sudoku.toString());
}
