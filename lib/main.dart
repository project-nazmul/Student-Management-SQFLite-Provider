import 'package:flutter/material.dart';
import 'package:sqflite_crud/database/db_student_manager.dart';
import 'package:sqflite_crud/screen/my_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DbStudentManager(),)
      ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


