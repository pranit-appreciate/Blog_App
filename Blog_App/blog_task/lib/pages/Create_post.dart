import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _textController = TextEditingController();


  Future<void> _createPost() async {
    final String text = _textController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in the post text")),
      );
      return;
    }

   

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('https://miniblog-backend-osjz.onrender.com/create-post'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: '{"text": "$text"}',
    );


    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create post")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 241, 244, 1),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text("Create Post",style: TextStyle(
          fontWeight: FontWeight.w600
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Share your thoughts with the community",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
             Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Title",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "eg. Dive into the project",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            SizedBox(height: 30),
            Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: _textController,
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "eg. Dive into the project",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            Spacer(),
            ElevatedButton(
              onPressed: _createPost,
              child:const Text("Create Post",style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(4, 97, 229, 1),
                
                minimumSize: Size(double.infinity, 53),
                shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15), 
        ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
