import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'models/UserModel.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void>  getUserApi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
    }
    else{
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("API Practice"),
    ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                  return Text("Loading");
              }
              else{
                return ListView.builder(
                  itemCount: data.length,
                    itemBuilder: (context, index){
                    return Card(
                      child: Column(
                        children: [
                                ReuseableRow(title: "Name", value: data[index]["name"].toString()),
                                ReuseableRow(title: "Username", value: data[index]["username"].toString()),
                                ReuseableRow(title: "Address", value: data[index]["address"]["street "].toString()),
                                ReuseableRow(title: "Geo", value: data[index]["address"]["geo"].toString()),
                        ],
                      ),
                    );
                    }
                );
              }

            },
          ))
        ],
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({Key? key , required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}