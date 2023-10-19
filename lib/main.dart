
import 'dart:async';
import 'package:database_app/Employees.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {

  // By Errors caused by Flutter Upgrade
  WidgetsFlutterBinding.ensureInitialized();

  // Open Database and store the references.
  final database = openDatabase(

    // Set the path to database
    /**
     *  The 'join' function is the best way/ good practice
     *  to implement the path correctly
     * */
      join(await getDatabasesPath(), 'emp_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE employees(id INTEGER PRIMARY KEY,name TEXT , email STRING)',
        );
      },
      version: 1
  );

  // Fetching/Retrieving the data..
  Future<List<Employees>> EmployeesList() async {
    // Get the reference
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('employees');

    return List.generate(maps.length, (index) {
      return Employees(
          id: maps[index]['id'],
          name: maps[index]['name'],
          email: maps[index]['email']);
    });
  }

  print(await EmployeesList());


  // Updating the data
  Future<void> updateEmployees(Employees employees) async {
    final db = await database;

    await db.update('employees', employees.toMap(),
      where: 'id =?',
      whereArgs: [employees.id],
    );
  }

   // Deleting the data
  Future<void> deleteEmployees(int id) async {
    final db = await database;

    await db.delete(
      'employees',
      where: 'id =?',
      whereArgs: [id],
    );
  }

   // Inserting the data
  Future<void> insertEmployee(Employees employees) async {
    // Getting a reference to the database
    final db = await database;

    // 'conflictAlgorithm - To use in case the same employee is inserted twice , TO replace any previous data'
    await db.insert('employees', employees.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  var Madhu =
  Employees(id: 01, name: 'Madhu', email: 'Madhu@gmail.com');

  var venkatesh =
  Employees(id: 02, name: 'venkatesh', email: 'venkatesh@gmail.com');

  var jitendra =
  Employees(id: 03, name: 'jitendra', email: 'jitendra@gmail.com');

  var Nagaharish =
  Employees(id: 04, name: 'Nagaharish', email: 'Nagaharish@gmail.com');

  var saiteja =
  Employees(id: 05, name: 'saiteja', email: 'saiteja@gmail.com');

  var rayudu =
  Employees(id: 06, name: 'rayudu', email: 'rayudu@gmail.com');

  saiteja = Employees(id: saiteja.id+08, name: saiteja.name, email: saiteja.email);

  await updateEmployees(saiteja);


  await insertEmployee(Madhu);
  await insertEmployee(venkatesh);
  await insertEmployee(jitendra);
  await insertEmployee(Nagaharish);
  await insertEmployee(saiteja);
  await insertEmployee(rayudu);



}
