import 'dart:convert';

import 'package:Sudoku/Data/data_fake.dart';
import 'package:Sudoku/Model/sudoku_level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Sudoku/UI/playing_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/sudoku_control.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50]!,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "BRIAN SUDOKU",
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          _Button(string: "Continue", state: 1),
          SizedBox(
            height: 30,
          ),
          _Button(string: "New Game", state: 0)
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({super.key, required this.string, required this.state});

  final String string;
  final int state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Center(
          child: Text(
            string,
            style: TextStyle(fontSize: 25, color: Colors.green),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.cyanAccent, borderRadius: BorderRadius.circular(25)),
        width: 200,
        height: 60,
      ),
      onTap: () {
        if (state == 1) {
          Navigator.pushNamed(
            context,
            "/PlayingPage",
          );
        } else {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ChooseLevel();
              });
        }
      },
    );
  }
}

class ChooseLevel extends StatelessWidget {
  const ChooseLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200]!,
                border: Border(
                bottom: BorderSide(color: Colors.greenAccent, width: 1)
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Choose Level",
                  style: TextStyle(fontSize: 20, color: Colors.greenAccent),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return LevelItem(numLevel: index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey,
                  thickness: 2,
                  indent: 2,
                  endIndent: 2,
                );
              },
              itemCount: data_level.length,
            ),
          ),
        ],
      ),
    );
  }
}

class LevelItem extends StatelessWidget {
  int numLevel;

  LevelItem({required this.numLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.greenAccent,
      padding: EdgeInsets.only(top: 1, bottom: 1,left: 8),
      child: ListTile(
        //minVerticalPadding: 10,
        focusColor: Colors.cyan,
        selectedTileColor: Colors.cyan,
        contentPadding: EdgeInsets.only(top: 0, right: 20, left: 10),
        title: Text(data_level[numLevel].title),
        subtitle:
            Text("${data_level[numLevel].size} x ${data_level[numLevel].size}"),
        leading: Icon(Icons.grid_on, color: Colors.blueGrey), // Biểu tượng trước tiêu đề
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey), // Biểu tượng mũi tên
        onTap: () {
          context.read<SudokuControl>().createSudoku(numLevel);
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            "/PlayingPage",
          );
        },
      ),
    );
  }
}
