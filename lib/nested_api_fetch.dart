import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_call/model/user_model.dart';
import 'package:http/http.dart' as http;

class NestedApiCall extends StatefulWidget {
  const NestedApiCall({super.key});

  @override
  State<NestedApiCall> createState() => _NestedApiCallState();
}

class _NestedApiCallState extends State<NestedApiCall> {
  List<UserModel> userList = [];

  Future<List<UserModel>> fetchApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    print(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: fetchApi(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: ((context, index) {
                    return Card(
                        child: ListTile(
                      title:
                          Text(snapshot.data![index].address!.city.toString()),
                    ));
                  }),
                );
              }
            },
          ),
        ),
      ],
    ));
  }
}
