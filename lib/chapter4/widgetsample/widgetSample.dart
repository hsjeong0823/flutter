import 'package:flutter/material.dart';

// class WidgetSample extends StatelessWidget {
//   const WidgetSample({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Widget Example',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const WidgetApp(),
//     );
//   }
// }

class WidgetApp extends StatefulWidget {
  const WidgetApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WidgetExampleState();
  }
}

class _WidgetExampleState extends State<WidgetApp> {
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List.empty(growable: true);
  String? _buttonText;

  @override
  void initState() {
    super.initState();
    for(var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(child: Text(item), value: item,));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text('결과 : $sum', style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(keyboardType: TextInputType.number, controller: value1,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(keyboardType: TextInputType.number, controller: value2,),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        var value1Int = double.parse(value1.value.text);
                        var value2Int = double.parse(value2.value.text);
                        var result;
                        if (_buttonText == _buttonList[0]) {
                          result = value1Int + value2Int;
                        } else if (_buttonText == _buttonList[1]) {
                          result = value1Int - value2Int;
                        } else if (_buttonText == _buttonList[2]) {
                          result = value1Int * value2Int;
                        } else {
                          result = value1Int / value2Int;
                        }

                        sum = '$result';
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add, color: Colors.black,),
                        Text(_buttonText!, style: TextStyle(color: Colors.black),)
                      ],
                    ),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: DropdownButton(items: _dropDownMenuItems, onChanged: (String? value) {
                  setState(() {
                    _buttonText = value;
                  });
                }, value: _buttonText,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
