import 'package:flutter/material.dart';
import 'package:flutter_app/chapter10/todo.dart';
import 'package:sqflite/sqflite.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> database;
  const AddTodoApp({Key? key, required this.database}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddTodoAppState();
  }
}

class _AddTodoAppState extends State<AddTodoApp> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO 추가'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: '제목'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: '할일'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Todo todo = Todo(
                        title: titleController.value.text,
                        content: contentController.value.text,
                        active: 0);
                    Navigator.of(context).pop(todo);
                  },
                  child: Text('저장하기')
              )
            ],
          ),
        ),
      ),
    );
  }

}