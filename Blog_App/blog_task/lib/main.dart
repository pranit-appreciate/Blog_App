import 'package:blog_task/pages/Authentication_page.dart';
import 'package:blog_task/pages/Create_post.dart';
import 'package:blog_task/pages/Edit_post.dart';
import 'package:blog_task/pages/Home_page.dart';
import 'package:blog_task/pages/profile_Page.dart';
 import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  Widget build(BuildContext context){
      return MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login':(context)=>AuthenticationPage(),
          '/home':(context)=>BlogPage(),
          '/create':(context)=>CreatePost(),
          '/editPost':(context)=>EditPostPage(),
          '/profile':(context)=>ProfilePage(),
        },
      );
  }
}