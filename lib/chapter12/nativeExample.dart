import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeApp extends StatefulWidget {
  const NativeApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NativeAppState();
  }
}

class _NativeAppState extends State<NativeApp> {
  static const platform = const MethodChannel('com.flutter.dev/info');
  static const platform2 = const MethodChannel('com.flutter.dev/encrypto');
  static const platform3 = const MethodChannel('com.flutter.dev/dialog');

  String deviceInfo = 'Unknown info';
  String changeText = "Nothing";
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Native Example')),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              Text(
                '## getDeviceInfo() ##',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                deviceInfo,
                style: TextStyle(fontSize: 15),
              ),
              ElevatedButton(onPressed: () {
                getDeviceInfo();
              }, child: Text('호출', style: TextStyle(fontSize: 20),)),

              SizedBox(height: 40,),
              Container(height: 10, color: Colors.black,),
              SizedBox(height: 40,),

              Text(
                '## sendData() ##',
                style: TextStyle(fontSize: 30),
              ),
              TextField(
                controller: textEditingController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 15),
              ),
              Text(
                  'result : $changeText',
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(onPressed: () {
                encodeData(textEditingController.value.text);
              }, child: Text('Base64 인코딩', style: TextStyle(fontSize: 20),)),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                decodeData(changeText);
              }, child: Text('Base64 디코딩', style: TextStyle(fontSize: 20),)),

              SizedBox(height: 40,),
              Container(height: 10, color: Colors.black,),
              SizedBox(height: 40,),

              Text(
                '## showDialog() ##',
                style: TextStyle(fontSize: 30),
              ),
              ElevatedButton(onPressed: () {
                showDialog();
              }, child: Text('다이알로그 호출', style: TextStyle(fontSize: 20),)),
            ],
          )
        ),
      ),
    );
  }

  Future<void> getDeviceInfo() async {
    String deviceInfo;
    try {
      String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device info : $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get Device info: ${e.message}';
    }
    setState(() {
      this.deviceInfo = deviceInfo;
    });
  }

  Future<void> encodeData(String text) async {
    String changeText;
    try {
      changeText = await platform2.invokeMethod('getEncrypto', text);
    } on PlatformException catch (e) {
      changeText = 'Nothing : ${e.message}';
    }
    setState(() {
      this.changeText = changeText;
    });
  }

  Future<void> decodeData(String text) async {
    String changeText;
    try {
      changeText = await platform2.invokeMethod('getDecode', text);
    } on PlatformException catch (e) {
      changeText = 'Nothing : ${e.message}';
    }
    setState(() {
      this.changeText = changeText;
    });
  }

  Future<void> showDialog() async {
    try {
      await platform3.invokeMethod('showDialog');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}