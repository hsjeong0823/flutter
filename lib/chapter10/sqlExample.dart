import 'package:flutter/material.dart';
import 'package:flutter_app/chapter10/addTodo.dart';
import 'package:flutter_app/chapter10/dataBase.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteApp extends StatelessWidget {
  const SQLiteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: FirstPageApp(),
      initialRoute: '/',
      routes: {
        '/': (context) => DataBaseApp(database: database),
        '/add': (context) => AddTodoApp(database: database)
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, active INTEGER)");
      },
      version: 1,
    );
  }
}
