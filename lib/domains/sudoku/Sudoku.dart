import 'dart:math';

class Sudoku {
  int boardSize = 9;
  int cellSize = 3;
  List<List<int>> initialBoard = getEmptyBoard(9);
  List<List<int>> finalBoard = getEmptyBoard(9);

  Sudoku() {
    _initialize();
    _scrambleBoards();
  }

  void _initialize() {
    var root = [
      [
        // Board 1
        [
          [0, 0, 0, 8, 0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 4, 3],
          [5, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 7, 0, 8, 0, 0],
          [0, 0, 0, 0, 0, 0, 1, 0, 0],
          [0, 2, 0, 0, 3, 0, 0, 0, 0],
          [6, 0, 0, 0, 0, 0, 0, 7, 5],
          [0, 0, 3, 4, 0, 0, 0, 0, 0],
          [0, 0, 0, 2, 0, 0, 6, 0, 0],
        ],
        [
          [2, 3, 7, 8, 4, 1, 5, 6, 9],
          [1, 8, 6, 7, 9, 5, 2, 4, 3],
          [5, 9, 4, 3, 2, 6, 7, 1, 8],
          [3, 1, 5, 6, 7, 4, 8, 9, 2],
          [4, 6, 9, 5, 8, 2, 1, 3, 7],
          [7, 2, 8, 1, 3, 9, 4, 5, 6],
          [6, 4, 2, 9, 1, 8, 3, 7, 5],
          [8, 5, 3, 4, 6, 7, 9, 2, 1],
          [9, 7, 1, 2, 5, 3, 6, 8, 4],
        ]
      ],
      //Board 2
      [
        [
          [0, 0, 0, 7, 0, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 4, 3, 0, 2, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 6],
          [0, 0, 0, 5, 0, 9, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 4, 1, 8],
          [0, 0, 0, 0, 8, 1, 0, 0, 0],
          [0, 0, 2, 0, 0, 0, 0, 5, 0],
          [0, 4, 0, 0, 0, 0, 3, 0, 0],
        ],
        [
          [2, 6, 4, 7, 1, 5, 8, 3, 9],
          [1, 3, 7, 8, 9, 2, 6, 4, 5],
          [5, 9, 8, 4, 3, 6, 2, 7, 1],
          [4, 2, 3, 1, 7, 8, 5, 9, 6],
          [8, 1, 6, 5, 4, 9, 7, 2, 3],
          [7, 5, 9, 6, 2, 3, 4, 1, 8],
          [3, 7, 5, 2, 8, 1, 9, 6, 4],
          [9, 8, 2, 3, 6, 4, 1, 5, 7],
          [6, 4, 1, 9, 5, 7, 3, 8, 2],
        ]
      ],
      //Board 3
      [
        [
          [6, 0, 2, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 7, 3, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 8, 0, 0, 9, 0, 2],
          [7, 1, 0, 0, 0, 5, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 8],
          [0, 0, 5, 9, 0, 0, 0, 0, 0],
          [0, 3, 0, 0, 0, 0, 0, 7, 0],
          [0, 0, 0, 0, 4, 0, 6, 0, 0],
        ],
        [
          [6, 5, 2, 4, 8, 1, 3, 9, 7],
          [1, 9, 4, 5, 7, 3, 2, 8, 6],
          [3, 8, 7, 6, 2, 9, 5, 4, 1],
          [5, 4, 3, 8, 6, 7, 9, 1, 2],
          [7, 1, 8, 2, 9, 5, 4, 6, 3],
          [2, 6, 9, 3, 1, 4, 7, 5, 8],
          [8, 7, 5, 9, 3, 6, 1, 2, 4],
          [4, 3, 6, 1, 5, 2, 8, 7, 9],
          [9, 2, 1, 7, 4, 8, 6, 3, 5],
        ]
      ],
    ];
    var rootPos = _getRandom(root.length);
    initialBoard = root[rootPos][0];
    finalBoard = root[rootPos][1];
  }

  void _scrambleBoards() {
    _scrambleRows();
    _scrambleCols();
    _scrambleFloors();
    _scrambleTowers();
    _randomizeDigits();
    _transposeBoards();
    _rotateBoards();
  }

  void _transposeBoards() {
    var r = _getRandom(2);
    if (r % 2 == 0) {
      _transposeBoard(initialBoard);
      _transposeBoard(finalBoard);
    }
  }

  void _transposeBoard(List board) {
    var temp = []..length = boardSize;
    for (var i = 0; i < boardSize; i++) {
      temp[i] = []..length = boardSize;
    }
    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        temp[i][j] = board[j][i];
      }
    }
    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        board[i][j] = temp[i][j];
      }
    }
  }

  void _rotateBoards() {
    var rotations = _getRandom(4);
    for (var i = 0; i < rotations; i++) {
      _rotateBoard(boardSize, initialBoard);
      _rotateBoard(boardSize, finalBoard);
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
    var digits = []..length = boardSize;
    for (var i = 0; i < boardSize; i++) {
      digits[i] = i + 1;
    }
    digits = _getRandomizedOrder(digits);
    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        var temp = finalBoard[i][j];
        finalBoard[i][j] = digits[temp - 1];
        temp = initialBoard[i][j];
        if (temp != 0) {
          initialBoard[i][j] = digits[temp - 1];
        }
      }
    }
  }

  List<int> _getRandomizedOrder(List arr) {
    var r = Random();
    var array = List<int>.from(arr);
    for (var i = 0; i < array.length; i++) {
      var randomPos = r.nextInt(array.length);
      var temp = array[i];
      array[i] = array[randomPos];
      array[randomPos] = temp;
    }
    return array;
  }

  List<int> _getNewPosOrder() {
    var indices = <int>[];
    for (var i = 0; i < boardSize; i++) {
      indices.add(i);
    }

    for (var i = 0; i < cellSize; i++) {
      var newOrder = indices.sublist(i * cellSize, i * cellSize + cellSize);
      newOrder = _getRandomizedOrder(newOrder);
      for (var j = 0; j < cellSize; j++) {
        indices[i * cellSize + j] = newOrder[j];
      }
    }
    return indices;
  }

  void _scrambleRows() {
    var indices = _getNewPosOrder();
    var initialCopy = getEmptyBoard(9);
    var finalCopy = getEmptyBoard(9);

    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        initialCopy[i][j] = initialBoard[indices[i]][j];
        finalCopy[i][j] = finalBoard[indices[i]][j];
      }
    }

    initialBoard = _copyTiles(initialCopy);
    finalBoard = _copyTiles(finalCopy);
  }

  void _scrambleCols() {
    var indices = _getNewPosOrder();
    var initialCopy = getEmptyBoard(9);
    var finalCopy = getEmptyBoard(9);
    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        initialCopy[i][j] = initialBoard[i][indices[j]];
        finalCopy[i][j] = finalBoard[i][indices[j]];
      }
    }

    initialBoard = _copyTiles(initialCopy);
    finalBoard = _copyTiles(finalCopy);
  }

  static List<List<int>> _copyTiles(List<List<int>> source) {
    var dest = getEmptyBoard(9);
    for (var i = 0; i < source.length; i++) {
      for (var j = 0; j < source.length; j++) {
        dest[i][j] = (source[i][j]);
      }
    }
    return dest;
  }

  static List<List<int>> getEmptyBoard(int boardSize) {
    var board = List<List<int>>.generate(
        boardSize, (i) => List<int>.filled(9, 0, growable: false));
    return board;
  }

  void _scrambleFloors() {
    var indices = _getNewPosOrder();
    var initialCopy = getEmptyBoard(9);
    var finalCopy = getEmptyBoard(9);
    for (var i = 0; i < cellSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        for (var k = 0; k < cellSize; k++) {
          initialCopy[indices[i] * cellSize + k][j] =
              initialBoard[i * cellSize + k][j];
          finalCopy[indices[i] * cellSize + k][j] =
              finalBoard[i * cellSize + k][j];
        }
      }
    }

    initialBoard = _copyTiles(initialCopy);
    finalBoard = _copyTiles(finalCopy);
  }

  void _scrambleTowers() {
    var indices = _getNewPosOrder();
    var initialCopy = getEmptyBoard(9);
    var finalCopy = getEmptyBoard(9);
    for (var i = 0; i < cellSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        for (var k = 0; k < cellSize; k++) {
          initialCopy[j][indices[i] * cellSize + k] =
              initialBoard[j][i * cellSize + k];
          finalCopy[j][indices[i] * cellSize + k] =
              finalBoard[j][i * cellSize + k];
        }
      }
    }

    initialBoard = _copyTiles(initialCopy);
    finalBoard = _copyTiles(finalCopy);
  }

  int _getRandom(int max) {
    var random = Random();
    return random.nextInt(max);
  }

  @override
  String toString() {
    var buffer = StringBuffer();
    buffer.write('Initial Board\n');
    buffer.write(boardToString(initialBoard));
    buffer.write('\n');
    buffer.write('Final Board\n');
    buffer.write(boardToString(finalBoard));
    return buffer.toString();
  }

  static String boardToString(List board) {
    var buffer = StringBuffer();
    var space = '';
    var divider = _makeDivider((sqrt(board.length)).toInt());
    for (var i = 0; i < sqrt(board.length); i++) {
      buffer.write(space);
      buffer.write(divider);
      space = '\n';
      for (var j = 0; j < sqrt(board.length); j++) {
        buffer.write(space);
        buffer.write(_rowToString(board[(i * 3 + j) % 9]));
      }
    }
    buffer.write(space + divider);
    return buffer.toString();
  }

  static String _rowToString(List board) {
    var buffer = StringBuffer();
    var spacer = '';
    for (var i = 0; i < board.length; i++) {
      if (i % board.length == 0) {
        spacer = '|';
      }

      buffer.write(spacer);
      var toPlace =
          board[i] == 0 || board[i] == '0' ? ' ' : board[i].toString();
      buffer.write(toPlace);
      spacer = ' ';
    }
    buffer.write('|');
    return buffer.toString();
  }

  static String _makeDivider(int cellSize) {
    var buffer = StringBuffer();
    for (var i = 0; i < cellSize + 1; i++) {
      buffer.write('+');
      if (i < 3) {
        for (var j = 0; j < cellSize * 2 - 1; j++) {
          buffer.write('-');
        }
      }
    }
    return buffer.toString();
  }
}
