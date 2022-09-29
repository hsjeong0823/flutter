import 'package:flutter/material.dart';
import '../animalItem.dart';

class FistApp extends StatelessWidget {
  final List<Animal>? list;

  const FistApp({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                child: Row(
                  children: [
                    Image.asset(list![index].imagePath!, height: 100, width: 100, fit: BoxFit.contain,),
                    Text(list![index].animalName!)
                  ],
                ),
              ),
              onTap: () {
                AlertDialog dialog = AlertDialog(
                  content: Text('이 동물은 ${list![index].kind} 입니다.', style: TextStyle(fontSize: 30.0),),
                );
                showDialog(context: context, builder: (BuildContext context) => dialog);
              },
            );
          }, itemCount: list!.length,)
        ),
      ),
    );
  }
}