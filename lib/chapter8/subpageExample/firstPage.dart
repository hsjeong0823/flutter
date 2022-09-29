import 'package:flutter/material.dart';

class FirstPageApp extends StatefulWidget {
  const FirstPageApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FirstPageAppState();
  }
}

class _FirstPageAppState extends State<FirstPageApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page Main'),
      ),
      body: Container(
        child: Center(
          child: Text('첫 번째 페이지'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPageApp(),));
          Navigator.of(context).pushNamed('/second');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}