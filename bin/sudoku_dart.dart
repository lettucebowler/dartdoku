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

  List<int> _getRandomizedOrder(List arr) {
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
      swapRows(positions[0], positions[1]);
    }
  }

  void _scrambleCols(int iterations) {
    for (var i = 0; i < board_size; i++) {
      // print(toString());
      var positions = _getPositionsToSwap();
      swapCols(positions[0], positions[1]);
    }
  }

  void swapRows(int pos1, int pos2) {
    for (var i = 0; i < board_size; i++) {
      var temp = final_board[pos1][i];
      final_board[pos1][i] = final_board[pos2][i];
      final_board[pos2][i] = temp;
    }
  }

  void swapCols(int pos1, int pos2) {
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

  void _preparePuzzle() {}

  @override
  String toString() {
    return _boardToString(final_board);
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
