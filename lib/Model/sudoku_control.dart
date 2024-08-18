import 'dart:math';
import 'dart:ui';

import 'package:Sudoku/Model/sudoku_logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Data/data_fake.dart';

class SudokuControl with ChangeNotifier {
  SudokuLogic sudokuLogic= SudokuLogic();
  late int temp;
  late int selectedRow ;
  late int selectedCol ;
  late int numBug;
  late int number = -1;

  void createSudoku (int level1){
    sudokuLogic.level=data_level[level1];
    sudokuLogic.numLevel=level1;
    sudokuLogic.createBoard();
    sudokuLogic.generateSudoku();
    sudokuLogic.removeNumbers();
    temp = sqrt(sudokuLogic.level.size).toInt();
    selectedRow = 0;
    selectedCol = 0;
    numBug=0;
    number=sudokuLogic.board[selectedRow][selectedCol];

    notifyListeners();
  }

  void selectCell(int row, int col) {
      selectedRow = row;
      selectedCol = col;
      number = sudokuLogic.board[row][col];
      notifyListeners();
  }

  void inputNumber(int number) {
    if (selectedRow != -1 && selectedCol != -1) {
        if (sudokuLogic.isValid(selectedRow, selectedCol, number)) {
         if (sudokuLogic.isSolve()){
           sudokuLogic.board[selectedRow][selectedCol] = number;
           sudokuLogic.count_num++;
         }

        } else
          numBug++;

      }
    notifyListeners();
  }
  bool isdefeat (){
    if (numBug>=3) return true;
    return false;
  }
  Color getColor(int row, int col, int num) {
    if (row == selectedRow && col == selectedCol && num == number) {
      return Colors.lightGreenAccent;
    } else if (row == selectedRow && col == selectedCol && num == 0) {
      return Colors.cyanAccent;
    } else if (num == number && number != 0) {
      return Colors.lightGreen;
    } else if (row == selectedRow || col == selectedCol) {
      return Colors.greenAccent;
    } else if ((selectedRow ~/ temp) == (row ~/ temp) &&
        (selectedCol ~/ temp) == (col ~/ temp) &&
        number != -1) {
      return Colors.greenAccent;
    } else
      return Colors.white;
  }


  void setSuduko(List<List<int>> board1){
    sudokuLogic.count_num=0;
    for(int i=0;i<sudokuLogic.level.size;i++){
      for(int j=0;j<sudokuLogic.level.size;j++){
        sudokuLogic.board[i][j]=board1[i][j];
        if(this.sudokuLogic.board[i][j]!=0){
          sudokuLogic.count_num++;
        }
      }
    }
    notifyListeners();
  }

}