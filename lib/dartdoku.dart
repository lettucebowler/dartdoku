//public packages
import 'dart:core';
import 'package:args/args.dart';

//My stuff
import 'domains/sudoku/SudokuProblem.dart';

String help =
    'Usage: sudoku [OPTION]...\nA simple dart program to generate and display a sudoku game.\n\n  -h, --help          Display this message\n  -i, --initialHints  number of givens on starting board, defaulting to 30';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('initialHints',
        abbr: 'i', help: 'number of givens on board', defaultsTo: '30')
    ..addFlag('help', abbr: 'h')
    ..addOption('count', abbr: 'n', defaultsTo: '1');

  var argResults = parser.parse(arguments);

  if (argResults['help']) {
    print(help);
  } else {
    var hints = int.parse(argResults['initialHints']) - 17;
    var count = int.parse(argResults['count']);
    var problems = getProblems(hints, count);
    for (SudokuProblem problem in problems) {
      print('Initial Board:');
      print(problem.getStateAsString(problem.getCurrentState()));
      print('Solution:');
      print(problem.getStateAsString(problem.getFinalState()));
    }
  }
}

List<SudokuProblem> getProblems(int hints, int count) {
  var problems = <SudokuProblem>[];
  for (var i = 0; i < count; i++) {
    var problem = SudokuProblem.withMoreHints(hints);
    problems.add(problem);
  }
  return problems;
}

SudokuProblem getProblem(int hints) {
  return SudokuProblem.withMoreHints(hints);
}
