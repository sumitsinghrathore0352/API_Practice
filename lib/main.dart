import 'package:api_practice/example_four.dart';
import 'package:api_practice/home_screen.dart';
import 'package:api_practice/signup.dart';
import 'package:api_practice/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'example_five.dart';
import 'example_three.dart';
import 'example_two.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:UploadImageScreen(),
    );
  }
}
