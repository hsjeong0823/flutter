import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/chapter10/sqlExample.dart';
import 'package:flutter_app/chapter12/nativeExample.dart';
import 'package:flutter_app/chapter4/imagfontaddapp/imageWidgetApp.dart';
import 'package:flutter_app/chapter5/listviewExample/listviewExample.dart';
import 'package:flutter_app/chapter5/tabbarExample/tabbarExample.dart';
import 'package:flutter_app/chapter7/httpExample/httpExample.dart';
import 'package:flutter_app/chapter7/largeFileDwonload/largeFileDownload.dart';
import 'package:flutter_app/chapter8/subpageExample/mainPage.dart';
import 'package:flutter_app/chapter8/todolistExample/todoListExample.dart';
import 'package:flutter_app/chapter9/fileExamle/fileExample.dart';
import 'package:flutter_app/chapter9/sharedPreferencesExample/shearedPreferenceExample.dart';

import 'chapter4/widgetsample/widgetSample.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: MyHomePage(title: 'Flutter Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '이미지/폰트 추가',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageWidgetApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '계산기',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WidgetApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '리스트뷰',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListViewApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '탭바',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TabBarApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '책검색 기능',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HttpApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '이미지 다운로드',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LargeFileApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '화면 전환',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPageApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '화면 전환(데이터 전달, 리스트 추가)',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TodoListApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'SharedPreferences',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SharePreferencesApp()));
              },
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'File Example',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FileApp()));
              },
            ),
            GestureDetector(
              child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'SQLite Example',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SQLiteApp()));
              },
            ),
            GestureDetector(
              child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Native Example',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NativeApp()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
