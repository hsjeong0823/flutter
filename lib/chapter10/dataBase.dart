import 'package:flutter/material.dart';
import 'package:flutter_app/chapter10/todo.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseApp extends StatefulWidget {
  final Future<Database> database;
  const DataBaseApp({Key? key, required this.database}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DataBaseAppState();
  }
}

class _DataBaseAppState extends State<DataBaseApp> {
  late Future<List<Todo>> todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Database Example'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              print('snapshot.connectionState : ${snapshot.connectionState}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    print('${(snapshot.data as List<Todo>).length}');
                    return ListView.builder(itemBuilder: (context, index) {
                      Todo todo = (snapshot.data as List<Todo>)[index];
                      // Card 위젯과 다르게 ListTile은 title, subtitle, leading, trailing옵션으로 위치를 지정
                      return ListTile(
                        title: Text(todo.title!, style: TextStyle(fontSize: 20),),
                        subtitle: Container(
                          child: Column(
                            children: [
                              Text(todo.content!),
                              Text('체크  : ${todo.active == 1 ? 'true' : 'false'}'),
                              Container(height: 1, color: Colors.blue,)
                            ],
                          ),
                        ),
                        onTap: () async {
                          TextEditingController controller = new TextEditingController(text: todo.content);

                          Todo result = await showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('${todo.id} : ${todo.title}'),
                              content: TextField(controller: controller, keyboardType: TextInputType.text,),
                              actions: [
                                TextButton(onPressed: (){
                                  todo.active == 1 ? todo.active = 0 : todo.active = 1;
                                  todo.content = controller.value.text;
                                  Navigator.of(context).pop(todo);
                                }, child: Text('예')),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop(todo);
                                }, child: Text('아니요')),
                              ],
                            );
                          });
                          _updateTodo(result);
                        },

                        onLongPress: () async {
                          Todo result = await showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('${todo.id} : ${todo.title}'),
                              content: Text('${todo.content}를 삭제하시겠습니까?'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop(todo);
                                }, child: Text('예')),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text('아니요')),
                              ],
                            );
                          });
                          if (result != null) {
                            _deleteTodo(result);
                          }
                        },
                      );
                    }, itemCount: (snapshot.data as List<Todo>).length,);
                  } else {
                    return Text('No data');
                  }
              }
            },
            future: todoList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context).pushNamed('/add');
          if (todo != null) {
            _insertTodo(todo as Todo);
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.database;
    await database.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.database;
    final List<Map<String, dynamic>> maps = await database.query('todos');
    print('maps : ${maps.length}');
    return List.generate(maps.length, (index) {
      int active = maps[index]['active'] == 1 ? 1 : 0;
      return Todo(
        title: maps[index]['title'].toString(),
        content: maps[index]['content'].toString(),
        active: active,
        id: maps[index]['id']
      );
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.database;
    await database.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);  // id 값으로 수정할 데이터 찾기
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.database;
    await database.delete('todos', where: 'id = ?', whereArgs: [todo.id]);  // id 값으로 수정할 데이터 찾기
    setState(() {
      todoList = getTodos();
    });
  }
}