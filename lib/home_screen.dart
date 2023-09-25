import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'models/PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList =[];
  Future<List<PostsModel>> getPostApi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
     for (Map<String, dynamic> item in data){
       postList.add(PostsModel.fromJson(item));
     }
     return postList;
    }else{
        return postList;
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
               future: getPostApi(),
               builder: (BuildContext context, AsyncSnapshot<List<PostsModel>> snapshot){
                       if(!snapshot.hasData){
                             return Text("Loading");
                       }else{
                            return ListView.builder(
                                itemCount: postList.length,
                                itemBuilder: (context , index){
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Title",
                                         style: TextStyle(
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,

                                         ),
                                      ),
                                      Text(postList[index].title.toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Description",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,

                                        ),
                                      ),
                                      Text(postList[index].body.toString()),
                                    ],
                                  ),
                                ),
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
