import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesApp extends StatefulWidget {
  const SharePreferencesApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SharePreferencesAppState();
  }
}

class _SharePreferencesAppState extends State<SharePreferencesApp> {
  int count = 0;

  // 데이터 저장
  void _setData(int value) async {
    var key = 'count';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  void _loadData() async {
    var key = 'count';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      var value = preferences.getInt(key);
      if (value != null) {
        count = value;
      } else {
        count = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count', style: TextStyle(fontSize: 40),),
            ElevatedButton(onPressed: () {
              setState(() {
                count++;
                _setData(count);
              });
            }, child: Text('+', style: TextStyle(fontSize: 30),)),
            ElevatedButton(onPressed: () {
              setState(() {
                if (count > 0) {
                  count--;
                  _setData(count);
                }
              });
            }, child: Text('-', style: TextStyle(fontSize: 30),)),
          ],
        ),
      ),
    );
  }
}