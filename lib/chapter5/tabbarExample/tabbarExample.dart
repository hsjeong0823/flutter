import 'package:flutter/material.dart';
import 'package:flutter_app/chapter5/tabbarExample/sub/firstPage.dart';
import 'package:flutter_app/chapter5/tabbarExample/sub/secondPage.dart';

class TabBarApp extends StatefulWidget {
  const TabBarApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabBarAppState();
  }
}

class _TabBarAppState extends State<TabBarApp> with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller?.addListener(() {
      if (!controller!.indexIsChanging) {
        print("이전 index, ${controller!.previousIndex}");
        print("현재 index, ${controller!.index}");
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Example'),
      ),
      body: TabBarView(
        controller: controller,
        children: [FistApp(), SecondApp()],
      ),
      bottomNavigationBar: TabBar(tabs: [
        Tab(icon: Icon(Icons.looks_one, color: Colors.blue,),),
        Tab(icon: Icon(Icons.looks_two, color: Colors.blue,),)
      ], controller: controller,),
    );
  }
}