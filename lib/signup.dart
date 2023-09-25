import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void login (String email , String password)async{
    try{
   Response response =await post(
     Uri.parse("https://reqres.in/api/register"),
     body : {
       "email": email,
       "password": password
     }
   );
   if(response.statusCode == 200){
     var data = jsonDecode(response.body.toString());
     print(data);
    print("Account created successfully");
   }
   else{
     print("Error");
   }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Password"
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString() , passwordController.text.toString());
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(10)
                ),
               child: Center(
                 child: Text("Sign Up"),
               ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
