import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Sudoku/UI/discover_tab.dart';
import 'package:Sudoku/UI/user_tab.dart';

import 'home_tab.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final List<Widget> _tabs = [
    HomeTab(),
    DiscoverTab(),
    UserTab()
  ];
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Soduko Game"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
          body: CupertinoTabScaffold (
            tabBuilder: (context,index){
              return _tabs[index];
            },
            tabBar: CupertinoTabBar (
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang Chu"),
                BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_outlined), label: "Kham Pha"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Ca Nhan"),
              ],
            ),

          ),
    ));
  }
}



