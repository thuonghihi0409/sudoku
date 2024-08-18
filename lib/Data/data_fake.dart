import 'package:Sudoku/Model/sudoku_level.dart';

final List<SudokuLevel> data_level = [
  SudokuLevel(size: 9, title: "Thử Nghiệm", number_remove: 3),
  SudokuLevel(size: 9, title: "Dễ Dàng", number_remove: 20),
  SudokuLevel(size: 9, title: "Trung Bình", number_remove: 30),
  SudokuLevel(size: 9, title: "Khó", number_remove: 40),
  SudokuLevel(size: 9, title: "Cao Thủ", number_remove: 50),
  SudokuLevel(size: 16, title: "Mở Rộng", number_remove: 80),
];

final Map<int, dynamic> mapnumber = {
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
  7: 7,
  8: 8,
  9: 9,
  10: "A",
  11: "B",
  12: "C",
  13: "D",
  14: "E",
  15: "F",
  16: "H"
};
