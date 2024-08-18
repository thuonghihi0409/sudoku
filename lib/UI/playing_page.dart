

import 'package:Sudoku/Data/data_fake.dart';
import 'package:Sudoku/Model/sudoku_control.dart';
import 'package:Sudoku/UI/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PlayingPage extends StatelessWidget {
  const PlayingPage({super.key});

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Playing Sudoku Game"),
      ),
      body: _Sudoku(),
    );
  }
}
class _Sudoku extends StatefulWidget {

  @override
  State<_Sudoku> createState() => _SudokuState();
}
class _SudokuState extends State<_Sudoku> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Colors.blueGrey,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.yellow[50]!,
      ),
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
               //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Item1(),
                      Flexible (
                        child:  Item2(),
                        fit: FlexFit.loose,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 150,
            ),
            Ttem3(),
          ],
        ),
      ),
    );
  }
}

class Item1 extends StatelessWidget {
  const Item1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Level: ${context.watch<SudokuControl>().sudokuLogic.level.title}"),
          Text("Loi: ${context.watch<SudokuControl>().numBug}/3"),
        ],
      ),
    );
  }
}

class Item2 extends StatefulWidget {
  const Item2({super.key});

  @override
  State<Item2> createState() => _Item2State();
}

class _Item2State extends State<Item2> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn của GridView
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.watch<SudokuControl>().sudokuLogic.level.size),
      itemBuilder: (context, index) {
        int row = index ~/ context.watch<SudokuControl>().sudokuLogic.level.size;
        int colum = index % context.watch<SudokuControl>().sudokuLogic.level.size;
        BorderSide borderSide = BorderSide(color: Colors.grey);
        Border border = Border(
          top: row % context.watch<SudokuControl>().temp == 0
              ? borderSide.copyWith(width: 1, color: Colors.black)
              : borderSide,
          bottom: (row + 1) % context.watch<SudokuControl>().temp == 0
              ? borderSide.copyWith(width: 1, color: Colors.black)
              : borderSide,
          left: colum % context.watch<SudokuControl>().temp == 0
              ? borderSide.copyWith(width: 1, color: Colors.black)
              : borderSide,
          right: (colum + 1) % context.watch<SudokuControl>().temp == 0
              ? borderSide.copyWith(width: 1, color: Colors.black)
              : borderSide,
        );
        return GestureDetector(
          onTap: () => context.read<SudokuControl>().selectCell(row, colum),
          child: GridTile(
            child: Container(
              decoration: BoxDecoration(
                  border: border,
                  color: context.read<SudokuControl>().getColor(
                      row, colum, context.watch<SudokuControl>().sudokuLogic.board[row][colum])
              ),
              child: Center(
                child: Text(
                    context.watch<SudokuControl>().sudokuLogic.board[row][colum] == 0
                      ? ""
                      : mapnumber[context.watch<SudokuControl>().sudokuLogic.board[row][colum]].toString(),
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: context.watch<SudokuControl>().sudokuLogic.level.size * context.watch<SudokuControl>().sudokuLogic.level.size,
    );
  }
}

class Ttem3 extends StatefulWidget {
  const Ttem3({super.key});

  @override
  State<Ttem3> createState() => _Ttem3State();
}

class _Ttem3State extends State<Ttem3> {
  @override
  Widget build(BuildContext context) {
    final sudokuControl = context.watch<SudokuControl>();
    final levelSize = sudokuControl.sudokuLogic.level.size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(levelSize, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: ElevatedButton(
                onPressed: () => sudokuControl.number == 0
                    ? click1(index)
                    : click2(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(2),
                  backgroundColor: Colors.cyan,
                  fixedSize: Size.fromHeight(60),
                  foregroundColor: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    mapnumber[index + 1].toString(),
                    style: const TextStyle(fontSize: 25, color: Colors.yellowAccent),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void click1(int index) {
    final sudokuControl = context.read<SudokuControl>();
    sudokuControl.inputNumber(index + 1);

    if (sudokuControl.isdefeat()) {
      _showDialog(
        context,
        title: "Thông Báo !!!!",
        message: "Trò Chơi Kết Thúc !!!!",
        onNewGame: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ChooseLevel();
              });
          //sudokuControl.createSudoku(sudokuControl.sudokuLogic.numLevel);
        },
      );
    } else if (sudokuControl.sudokuLogic.count_num >=
        sudokuControl.sudokuLogic.level.size * sudokuControl.sudokuLogic.level.size) {
      _showDialog(
        context,
        title: "Chúc Mừng !!!!",
        message: "Bạn đã hoàn thành trò chơi !!!!",
        onNewGame: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ChooseLevel();
              });
         // sudokuControl.createSudoku(sudokuControl.sudokuLogic.numLevel);
        },
      );
    }
  }

  void click2() {
    _showErrorDialog(context, "Không thể thay đổi ô đúng");
  }

  void _showDialog(BuildContext context, {required String title, required String message, required VoidCallback onNewGame}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 300,
            child: Center(child: Text(message)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onNewGame();
              },
              child: const Text("Ván mới"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/MyHomePage");
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thông báo"),
          content: Text(message, style: const TextStyle(color: Colors.red)),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
            ),
          ],
        );
      },
    );
  }
}





