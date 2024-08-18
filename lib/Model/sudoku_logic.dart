import 'dart:math';

import 'package:Sudoku/Data/data_fake.dart';
import 'package:Sudoku/Model/sudoku_level.dart';
import 'package:flutter/foundation.dart';

class SudokuLogic {

  int numLevel=0 ;
  SudokuLevel level = data_level[0];
  int count_num=0;
  late List<List<int>> board;
  void createBoard (){
    board = List.generate(level.size, (_) => List.generate(level.size, (_) => 0));
  }
  bool isValid(int row, int col, int num) {
    int tem= sqrt(level.size).toInt();
    for (int i = 0; i < level.size; i++) {
      if (board[row][i] == num || board[i][col] == num || board[row - row % tem + i ~/ tem][col - col % tem + i % tem] == num) {
        return false;
      }
    }
    return true;
  }
bool isSolve (){
    SudokuLogic temp = SudokuLogic();
    temp.board=List.generate(level.size, (i) => List.generate(level.size, (j) => board[i][j]));
    temp.level=level;
    return temp.solveSudoku();
}
  bool solveSudoku() {
    for (int row = 0; row < level.size; row++) {
      for (int col = 0; col < level.size; col++) {
        if (board[row][col] == 0) {
          for (int num = 1; num <= level.size; num++) {
            if (isValid(row, col, num)) {
              board[row][col] = num;
              if (solveSudoku()) {
                return true;
              }
              board[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    count_num= 81;
    return true;
  }

  void generateSudoku() {
    Random random = Random();
    int count = 0;
    while (count < 17) {
      int row = random.nextInt(level.size);
      int col = random.nextInt(level.size);
      int num = random.nextInt(level.size) + 1;
      if (board[row][col] == 0 && isValid(row, col, num)) {
        board[row][col] = num;
        count++;
      }
    }
    solveSudoku();
  }

  void removeNumbers() {
    count_num=level.size*level.size - level.number_remove;
    int attempts = level.number_remove;
    Random random = Random();
    while (attempts > 0) {
      int row = random.nextInt(level.size);
      int col = random.nextInt(level.size);
      while (board[row][col] == 0) {
        row = random.nextInt(level.size);
        col = random.nextInt(level.size);
      }
      //int backup = board[row][col];
      board[row][col] = 0;
      attempts--;
      // List<List<int>> copyBoard = board.map((row) => row.toList()).toList();
      // SudokuLogic temp = SudokuLogic();
      // temp.board=copyBoard;
      // if (!temp.solveSudoku()) {
      //   board[row][col] = backup;
      //   attempts--;
      // }
    }
  }

}