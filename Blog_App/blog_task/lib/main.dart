import 'package:blog_task/pages/Authentication_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  Widget build(BuildContext context){
      return MaterialApp(
        home: AuthenticationPage(),
      );
  }
}