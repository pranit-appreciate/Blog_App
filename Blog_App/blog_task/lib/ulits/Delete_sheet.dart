
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteSheet extends StatefulWidget {
  final String postId;
  final Function fetchPosts;
  const DeleteSheet({Key? key, required this.postId,required this.fetchPosts,}) : super(key: key);

  @override
  _DeleteSheetState createState() => _DeleteSheetState();
}

class _DeleteSheetState extends State<DeleteSheet> {
  List<Map<String, dynamic>> posts = [];
  bool isLoading = false;

Future<void> _deletePost(int postId) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null) return;

  print(postId);
  final response = await http.delete(
    Uri.parse('https://miniblog-backend-osjz.onrender.com/delete-post/$postId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

 
  print("Response Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Post deleted successfully')),
    );
    
    widget.fetchPosts();  
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete post')),
    );
  }


  Navigator.of(context).pop(false);
}


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width, 
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Image.asset(
            'assets/warning.png', 
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        SizedBox(height: 20),
          Text(
            'Delete this post?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Text('Are you sure you want to delete',style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16
            ),),
            Text('this post',style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16
            ),),
            ],
          ),
          SizedBox(height: 10,),
          Column(
            children: [
              
               ElevatedButton(
                onPressed: () => _deletePost(int.parse(widget.postId)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(4, 97, 229, 1),
                  minimumSize: Size(double.infinity, 53),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white) 
                    : Text('Yes',style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(4, 97, 229, 1),
                  minimumSize: Size(double.infinity, 53),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text('No',style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}
