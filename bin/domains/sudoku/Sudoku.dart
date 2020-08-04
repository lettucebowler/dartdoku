import 'dart:math';

class Sudoku {
  int board_size;
  int cell_size;
  int hint_offset;
  List initial_board;
  List final_board;

  Sudoku() {
    _initialize();
    _scrambleBoards();
    _addClues(hint_offset);
  }

  Sudoku.withMoreHints(int hint_offset) {
    _initialize();
    this.hint_offset = hint_offset;
    _scrambleBoards();
    _addClues(hint_offset);
  }

  void _initialize() {
    cell_size = 3;
    board_size = cell_size * cell_size;
    hint_offset = 0;
    initial_board = [
      [0, 0, 0, 8, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 4, 3],
      [5, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 7, 0, 8, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 2, 0, 0, 3, 0, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 0, 7, 5],
      [0, 0, 3, 4, 0, 0, 0, 0, 0],
      [0, 0, 0, 2, 0, 0, 6, 0, 0]
    ];

    final_board = [
      [2, 3, 7, 8, 4, 1, 5, 6, 9],
      [1, 8, 6, 7, 9, 5, 2, 4, 3],
      [5, 9, 4, 3, 2, 6, 7, 1, 8],
      [3, 1, 5, 6, 7, 4, 8, 9, 2],
      [4, 6, 9, 5, 8, 2, 1, 3, 7],
      [7, 2, 8, 1, 3, 9, 4, 5, 6],
      [6, 4, 2, 9, 1, 8, 3, 7, 5],
      [8, 5, 3, 4, 6, 7, 9, 2, 1],
      [9, 7, 1, 2, 5, 3, 6, 8, 4]
    ];
  }

  void _scrambleBoards() {
    // var max_iterations = 15;
    // _scrambleRows();
    // _scrambleCols();
    _scrambleFloors();
    // _scrambleTowers();
    // _randomizeDigits();
    // _transposeBoards();
    // _rotateBoards();
  }

  void _addClues(int hint_offset) {
    var pos1;
    var pos2;
    var i;
    for (i = 0; i < hint_offset; i++) {
      do {
        pos1 = _getRandom(board_size);
        pos2 = _getRandom(board_size);
      } while (initial_board[pos1][pos2] != 0);
      initial_board[pos1][pos2] = final_board[pos1][pos2];
      if (initial_board[pos2][pos1] == 0) {
        initial_board[pos2][pos1] = final_board[pos2][pos1];
        i++;
      }
    }
  }

  void _transposeBoards() {
    var r = _getRandom(2);
    if (r % 2 == 0) {
      _transposeBoard(initial_board);
      _transposeBoard(final_board);
    }
  }

  void _transposeBoard(List board) {
    var temp = List(board_size);
    for (var i = 0; i < board_size; i++) {
      temp[i] = List(board_size);
    }
    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board_size; j++) {
        temp[i][j] = board[j][i];
      }
    }
    for (var i = 0; i < board_size; i++) {
      for (var j = 0; j < board_size; j++) {
        board[i][j] = temp[i][j];
      }
    }
  }

  void _rotateBoards() {
    var rotations = _getRandom(4);
    for (var i = 0; i < rotations; i++) {
      _rotateBoard(board_size, initial_board);
      _rotateBoard(board_size, final_board);
    }
  }

  void _rotateBoard(int N, List board) {
    for (var x = 0; x < N / 2; x++) {
      for (var y = x; y < N - x - 1; y++) {
        var temp = board[x][y];
        board[x][y] = board[y][N - 1 - x];
        board[y][N - 1 - x] = board[N - 1 - x][N - 1 - y];
        board[N - 1 - x][N - 1 - y] = board[N - 1 - y][x];
        board[N - 1 - y][x] = temp;
      }
    }
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
        temp = initial_board[i][j];
        if (temp != 0) {
          initial_board[i][j] = digits[temp - 1];
        }
      }
    }
  }

  List<int> _getRandomizedOrder(List arr) {
    var r = Random();
    var array = List<int>.from(arr);
    for (var i = 0; i < array.length; i++) {
      var random_pos = r.nextInt(array.length);
      var temp = array[i];
      array[i] = array[random_pos];
      array[random_pos] = temp;
    }
    return array;
  }

  void _scrambleRows() {
    var indices = List(cell_size);
    for (var i = 0; i < cell_size; i++) {
      indices[i] = i;
    }
    for (var i = 0; i < cell_size; i++) {
      var new_order = _getRandomizedOrder(indices);
      // for (var j = 0; j < cell_size - 1; j++) {
      //   _swapRows(initial_board, j, new_order[j]);
      //   _swapRows(final_board, j, new_order[j]);
      // }
    }
  }

  void _scrambleCols() {
    var indices = List(cell_size);
    for (var i = 0; i < cell_size; i++) {
      indices[i] = i;
    }
    for (var i = 0; i < cell_size; i++) {
      var new_order = _getRandomizedOrder(indices);
      for (var j = 0; j < cell_size - 1; j++) {
        _swapCols(initial_board, j, new_order[j]);
        _swapCols(final_board, j, new_order[j]);
      }
    }
  }

  // void _scrambleFloors() {
  //   var indices = List(cell_size);
  //   for (var i = 0; i < cell_size; i++) {
  //     indices[i] = i;
  //   }
  //   var new_order = _getRandomizedOrder(indices);
  //   print(new_order.toString());
  //   for (var i = 0; i < cell_size; i++) {
  //     _swapFloors(initial_board, i, new_order[i]);
  //     _swapFloors(final_board, i, new_order[i]);
  //   }
  // }

  // void _swapFloors(List board, pos1, pos2) {
  //   for (var i = 0; i < cell_size; i++) {
  //     _swapRows(board, pos1 * cell_size + i, pos2 * cell_size + i);
  //   }
  // }

  // void _scrambleTowers() {}

  void _swapRows(List board, int pos1, int pos2) {
    for (var i = 0; i < board_size; i++) {
      var temp = board[pos1][i];
      board[pos1][i] = board[pos2][i];
      board[pos2][i] = temp;
    }
  }

  void _swapCols(List board, int pos1, int pos2) {
    for (var i = 0; i < board_size; i++) {
      var temp = board[i][pos1];
      board[i][pos1] = board[i][pos2];
      board[i][pos2] = temp;
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
  var sudoku = Sudoku.withMoreHints(0);
  print(sudoku.toString());
}
