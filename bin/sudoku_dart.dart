//public packages
import 'dart:core';
import 'package:args/args.dart';

//My stuff
import 'domains/sudoku/SudokuProblem.dart';
import 'domains/sudoku/SudokuState.dart';
import 'framework/problem/SolvingAssistant.dart';

SudokuProblem problem;
SolvingAssistant assistant;
int board_size;
int cell_size;
ArgResults argResults;
String help =
    'Usage: sudoku [OPTION]...\nA simple dart program to generate and display a sudoku game.\n\n  -h, --help          Display this message\n  -i, --initialHints  number of givens on starting board, defaulting to 30';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('initialHints',
        abbr: 'i', help: 'number of givens on board', defaultsTo: '30')
    ..addFlag('help', abbr: 'h');

  argResults = parser.parse(arguments);

  if (argResults['help']) {
    print(help);
  } else {
    var hints = int.parse(argResults['initialHints']) - 17;
    problem = SudokuProblem.withMoreHints(hints);
    SudokuState current_state = problem.getCurrentState();
    print('Initial Board:');
    print(problem.getStateAsString(current_state));
    print('Solution:');
    print(problem.getStateAsString(problem.getFinalState()));
  }
}
