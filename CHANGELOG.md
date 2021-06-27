# 1.2.3
fixed SudokuState.fromString() bug

# 1.2.2
minor tweaks

# 1.2.1
renamed old problem constructor and added new one

# 1.2.0
remove problem framework and just implement the inherited logic into the SudokuProblem and SudokuState classes. Too simple to use a framework for that.

# 1.1.3

# 1.1.2

# 1.1.1

# 1.1.0
ignored .failed_tracker
add board encoder for api

# 1.0.4
update to async logic
upgrade to 1.0.3 and change getProblems to async
update to not rely on Sudoku.dart when calling addClues
updated to modern sudokuproblem framework
omit type annotation in local variables
added bin for local testing
add version and homepage to pubspec
rename package
changed workflow of sudoku board generation
removed dependence on Mover
update for sound null-safety
update to use dart compile
Update 'README.md'
added cli parsing for initial hints, and a -h flag to learn how to use the program.
got rid of the game solver, as the game generation checks for validity, so it isn't necessary to prove that it is solvable. Now it just prints the finalState instead of solving, and printing currentState.
added a third root puzzle
test script makes the build dir now so it doesn't break
removed hint offset from SudokuProblem.resume()
made another tester to time vm for performance comparisons
removed hint_offset membet as it isn't required to have a hint offset
fixed issue where _addClues could add an extra clue
removed useless file
added a test script to measure performance.also made some other minor changes.
generation seems to work again now
fix to row and column reordering
broken
changed scrambleRows and scrambleCols() to create a random 1-1 mapping of the rows/cols instead of randomly swapping i iterations.
Minor output change on test code
solveGame only tries a move on cells that are not correct.
fixed problem.success()
reworked sudoku_dart.dart to create a SudokuProblem and solve it
fixed constructor to initialize this.problem.
fixed _copyTiles to not call add on null
problem creation seems to work. Now to test movers
modified sudoku_dart to import sudoku instead of use an in-file definition
initial conversion complete. Moving to testing phase to find and fix issues.
removed SolvingAssistant.java
added in problem framework. Working on conversion from java to dart
removed debug print
removed obvious comments from _rotateBoard()
added transposition and rotation of boards.
Changed generation to add to a minimal board instead of remove from a complete board. This change removes the need to count solutions and do a backtracking solve after each removal.
I think I'm close
I'm noticing changes, at least.
grrr
why no worky
it always thinks there are multiple solutions
fixed swap logic on rows and cols
initial transfer of board scramble logic
.vscode dir added
toString() now works
board outputs correctly now
working on board generation
added pubspec lock
initial commit of empty project

## 1.0.4

- async changes
