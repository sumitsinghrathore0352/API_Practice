import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);
  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList =[];
  Future<List<Photos>> getPhotos() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for (Map<String, dynamic> item in data){
       Photos photos = Photos(title: item["title"], url:item ["url"], id: item["id"]);
       photosList.add(photos);
      }
      return photosList;
    }
    else{
      return photosList;
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
            Expanded(
              child: FutureBuilder(
                  future: getPhotos(),
                  builder: (context,AsyncSnapshot<List<Photos>> snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading...");
                    }
                    else{
                      return ListView.builder(
                         itemCount: photosList.length,
                          itemBuilder: (context , index){
                           return ListTile(
                             leading: CircleAvatar(
                               backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                             ),
                             title: Text("Notes id : "+snapshot.data![index].id.toString()),
                             subtitle:  Text(snapshot.data![index].title.toString()),
                           );
                      });
                    }
                  }),
            )
        ],
      ),
    );
  }
}

class Photos {
  String  title , url ;
  int id;
  Photos({required this.title , required this.url, required this.id});
}