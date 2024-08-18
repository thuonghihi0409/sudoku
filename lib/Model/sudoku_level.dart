import 'package:flutter/cupertino.dart';

class SudokuLevel {
  final int size;
  final int number_remove;
  final String title;

  SudokuLevel({
    required this.size,
    required this.title,
    required this.number_remove,
  });
  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'title': title,
      'number_remove': number_remove,
    };
  }
  factory SudokuLevel.fromJson(Map<String, dynamic> map) {
    debugPrint (map["size"]);
    debugPrint (map["title"]);
    debugPrint (map["number_remove"]);
    return SudokuLevel(
        size: map["size"],
        title: map["title"],
        number_remove: map["number_remove"]);
  }
}
