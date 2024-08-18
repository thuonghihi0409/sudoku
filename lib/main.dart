
import 'package:Sudoku/Model/sudoku_control.dart';

import 'package:Sudoku/UI/playing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/home_app.dart';

void  main(){

  runApp(
    ChangeNotifierProvider(
      create: (context) => SudokuControl(),
      child: MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello",
      initialRoute: "/",
      routes: {
        "/MyHomePage" : (context) => MyHomePage(),
        "/PlayingPage" : (context) =>PlayingPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.greenAccent,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
