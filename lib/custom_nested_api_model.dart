import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_call/model/user_model.dart';
import 'package:http/http.dart' as http;

class CustomNestedApiCall extends StatefulWidget {
  const CustomNestedApiCall({super.key});

  @override
  State<CustomNestedApiCall> createState() => _CustomNestedApiCallState();
}

class _CustomNestedApiCallState extends State<CustomNestedApiCall> {
  var data;
  Future fetchApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    print("print==>>" + response.body);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: fetchApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Text(data![index]["address"]["geo"]["lat"]),
                      ));
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
