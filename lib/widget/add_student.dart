import 'package:flutter/material.dart';
import 'package:sqflite_crud/database/db_student_manager.dart';
import 'package:sqflite_crud/model/student.dart';
import 'package:provider/provider.dart';

addStudent({required BuildContext context,required String name, required String course}){
  final provider = Provider.of<DbStudentManager>(context,listen: false);
  Student st =  Student(name: name, course: course);
  provider.insertStudent(st).then((id)=>{
    print('Student Added to Db ${id}')
  });

}

