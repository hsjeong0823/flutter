import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpApp extends StatefulWidget {
  const HttpApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HttpAppState();
  }
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  List? data;
  TextEditingController? _textEditingController;
  ScrollController? _scrollController;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
    _textEditingController = new TextEditingController();
    _scrollController = new ScrollController();

    _scrollController!.addListener(() {
      if (_scrollController!.offset >= _scrollController!.position.maxScrollExtent &&
      !_scrollController!.position.outOfRange) {
        print('bottom');
        page++;
        getJsonData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textEditingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Container(
        child: Center(
          child: data!.length == 0
              ? Text('데이터가 없습니다.', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
              : ListView.builder(itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    child: Row(
                      children: [
                        Image.network(
                          data![index]['thumbnail'], height: 100, width: 100, fit: BoxFit.contain,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(data![index]['title'].toString(), textAlign: TextAlign.center,),
                            ),
                            Text('저자 : ${data![index]['authors'].toString()}'),
                            Text('가격 : ${data![index]['sale_price'].toString()}'),
                            Text('판매중 : ${data![index]['status'].toString()}'),
                          ],
                        )
                      ], mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                );
          }, itemCount: data!.length, controller: _scrollController,)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          page = 1;
          data!.clear();
          getJsonData();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJsonData() async {
    var url = 'https://dapi.kakao.com/v3/search/book?page=$page&size=10&query=${_textEditingController!.value.text}&target=title';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK f0e89f7b143cc3f1c612a1fcc447ffad"});
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}