import 'package:flutter/material.dart';
import 'package:lesson_52_homework/views/screens/home_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}