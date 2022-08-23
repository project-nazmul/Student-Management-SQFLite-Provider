import 'package:flutter/material.dart';
import 'package:sqflite_crud/database/db_student_manager.dart';
import 'package:provider/provider.dart';

deleteStudent({required BuildContext context,required int id}){
  final provider = Provider.of<DbStudentManager>(context,listen: false);
  provider.deleteStudent(id);
}