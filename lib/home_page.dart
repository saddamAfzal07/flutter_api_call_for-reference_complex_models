import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_call/model/list_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelList> postList = [];
  Future<List<ModelList>> getPostApi() async {
    print("Api call");
    var url = "https://jsonplaceholder.typicode.com/posts";

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(ModelList.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return Text(postList[index].body.toString());
                });
          }
        },
      ),
    );
  }
}
