//public packages
import 'dart:core';
import 'package:args/args.dart';
import 'package:dartdoku/dartdoku.dart';
import 'package:dartdoku/domains/sudoku/SudokuProblem.dart';

String help =
    'Usage: sudoku [OPTION]...\nA simple dart program to generate and display a sudoku game.\n\n  -h, --help          Display this message\n  -i, --initialHints  number of givens on starting board, defaulting to 30';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('initialHints',
        abbr: 'i', help: 'number of givens on board', defaultsTo: '17')
    ..addFlag('help', abbr: 'h')
    ..addOption('count', abbr: 'n', defaultsTo: '1');

  var argResults = parser.parse(arguments);

  if (argResults['help']) {
    print(help);
  } else {
    var hints = int.parse(argResults['initialHints']);
    var count = int.parse(argResults['count']);
    var problems = getProblems(hints, count);
    for (var problem in problems) {
      print('Initial board');
      print(SudokuProblem.stateToString(problem.getInitialState()));
      print('\nFinal Board');
      print(SudokuProblem.stateToString(problem.getFinalState()));
    }
  }
}
