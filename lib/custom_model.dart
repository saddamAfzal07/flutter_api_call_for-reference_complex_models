import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_call/model/list_model.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Photos> postList = [];
  Future<List<Photos>> getPostApi() async {
    print("Api call");
    var url = "https://jsonplaceholder.typicode.com/photos";

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i["title"], url: i["url"]);
        postList.add(photos);
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
        builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title.toString()),
                  );
                });
          }
        },
      ),
    );
  }
}

class Photos {
  String title;

  String url;
  Photos({required this.title, required this.url});
}
