import 'package:flutter/material.dart';

class SecondDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SecondDetail();
  }
}

class _SecondDetail extends State<SecondDetail> {
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        child: Center(
          child: Column (
            children: [
              TextField(
                controller: textEditingController,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(textEditingController.value.text);
                },
                child: Text('저장하기')
              )
            ],
          )
        ),
      ),
    );
  }
}