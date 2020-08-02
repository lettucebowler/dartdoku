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
    for (var i = 0; i < board_size; i++) {
      buffer.write(space);
      var row = _rowToString(board[i]);
      buffer.write(row);
      space = '\n';
    }

    return buffer.toString();
  }

  String _rowToString(List board) {
    var row_buffer = StringBuffer();
    var row_spacer = '';
    for (var i = 0; i < board_size; i++) {
      row_buffer.write(row_spacer);
      row_buffer.write(board[i]);
      row_spacer = ' ';
    }
    return row_buffer.toString();
  }
}

void main(List<String> arguments) {
  var sudoku = Sudoku();
  print(sudoku.toString());
}
