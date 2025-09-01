// comment_sheet.dart
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentSheet extends StatefulWidget {
  final String postId;
  
  const CommentSheet({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentSheetState createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  List<Map<String, dynamic>> comments = [];
  final TextEditingController _controller = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    print("fetch comment");
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('https://miniblog-backend-osjz.onrender.com/all-comments/${widget.postId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        comments = List<Map<String, dynamic>>.from(data['comments']);
        isLoading = false;
      });
    }
  }

  Future<void> postComment() async {
    final text = _controller.text.trim();
    
    if (text.isEmpty) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(text);
    print(widget.postId);
    final response = await http.post(
      Uri.parse('https://miniblog-backend-osjz.onrender.com/create-comment/${widget.postId}'),
      headers: {
  'Authorization': 'Bearer $token',
  'Content-Type': 'application/json',
},
body: json.encode({'text': text}),

    );

    if (response.statusCode == 200) {
  _controller.clear();
  await fetchComments(); 
}

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Comments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 15),
            Expanded(
              child:
                  ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          subtitle: Text(comment['text'],style: TextStyle(
                            fontSize: 20
                          ),),
                          
                          title: Row(
                            children: [
                              Text("UserName",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),),
                          SizedBox(width: 20),
                          Text("2 days") ,
                          Spacer(),
                          Icon(Icons.favorite_border, color: const Color.fromARGB(255, 124, 124, 124), size: 20),
                            ],
                          )
                          
                        );
                      },
                    ),
            ),
            Row(
  children: [
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0461E5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Image.asset('assets/sent.png',color: Colors.white,),
        onPressed: postComment,
        padding: EdgeInsets.zero,
      ),
    ),
            hintText: 'Add a comment...',
            border: InputBorder.none,
          ),
        ),
      ),
    ),
    SizedBox(width: 0),
    
  ],
),
          ],
        ),
      ),
    );
  }
}

