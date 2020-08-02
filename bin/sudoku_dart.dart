import 'package:sudoku_dart/sudoku_dart.dart' as sudoku_dart;
import 'dart:convert';

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
    generateFilled();
  }

  void generateFilled() {
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

  void scrambleBoard() {}

  void preparePuzzle() {}

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
