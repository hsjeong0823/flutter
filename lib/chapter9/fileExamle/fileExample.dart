import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class FileApp extends StatefulWidget {
  const FileApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FileAppState();
  }
}

class _FileAppState extends State<FileApp> {
  int _count = 0;
  List<String> itemList = new List.empty(growable: true);
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    readCountFile();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text('count.txt 저장 및 로드 테스트 \ncount : $_count'),
              ),
              Text('==================================='),

              TextField(controller: textEditingController, keyboardType: TextInputType.text,),

              // Column 이나 Row위젯은 내용에 따라 알아서 크기를 조절해서 배치하지만, ListView는 길이를 가늠할 수 없으므로 Expended사용.
              // Expended 위젯은 남은 공간을 모두 사용. 즉 위에 추가된 뷰 이외에 부분은 ListView가 사용하겠다는 의미.
              Expanded(child: ListView.builder(itemBuilder: (context, index) {
                return Card(
                    child: Center(
                      child: Text(itemList[index], style: TextStyle(fontSize: 30),),
                    )
                );
              }, itemCount: itemList.length,))
            ],
          ),
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
            writeCountFile(_count);

            writeFruit(textEditingController.value.text);
            setState(() {
              itemList.add(textEditingController.value.text);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void writeCountFile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }

  void readCountFile() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> readListFile() async {
    List<String> itemList = new List.empty(growable: true);
    var key = 'first';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? firshCheck = preferences.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/fruit.txt').exists();

    var file;
    if (firshCheck == null || !firshCheck || !fileExist) {
      print('first check');
      preferences.setBool(key, true);
      file = await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');
      File(dir.path + '/fruit.txt').writeAsStringSync(file);
    } else {
      var dir = await getApplicationDocumentsDirectory();
      file = await File(dir.path + '/fruit.txt').readAsString();
    }

    var array = file.split('\n');
    for (var item in array) {
      print(item);
      itemList.add(item);
    }
    return itemList;
  }

  void writeFruit(String fruit) async {
    print('writeFruit() fruit : $fruit');
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/fruit.txt').readAsString();
    file = file + '\n' + fruit;
    File(dir.path + '/fruit.txt').writeAsStringSync(file);
  }
}

/*
class _FileAppState extends State<FileApp> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    readCountFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Example'),
      ),
      body: Container(
        child: Text('$_count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
            writeCountFile(_count);
          });
        },
      ),
    );
  }

  void writeCountFile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }

  void readCountFile() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}*/
