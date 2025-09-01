import 'dart:convert';
import 'package:blog_task/ulits/Delete_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ulits/Comment_sheet.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<dynamic> posts = [];
  bool isLoading = true;
  int _selectedIndex = 0;
  String? name = '';

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  //making changes
  Future<void> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    setState(() {
      print(prefs.getString('name'));
      name = prefs.getString('name');
    });

    if (token == null) {
      print("Token not found");
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://miniblog-backend-osjz.onrender.com/my-posts'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print("Posts fetched: ${data['username']}");
        setState(() {
          //  name=data['username'];
          posts = data['posts'];
          isLoading = false;
        });
      } else {
        print("Failed to fetch posts: ${response.body}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching posts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(246, 246, 249, 1.0),

          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE0E6F0)),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                title: Text(
                  'Edit post',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF1A1A1A),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/editPost',
                    arguments: {'postId': posts[index]['id'].toString()},
                  );
                },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE0E6F0)),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                title: Text(
                  'Delete post',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF1A1A1A),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _deletePost(posts[index]['id'].toString());
                },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE0E6F0)),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                title: Text(
                  'Hide',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF1A1A1A),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deletePost(String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DeleteSheet(postId: postId, fetchPosts: fetchPosts),
    );
  }

  Widget buildPostItem(Map<String, dynamic> post) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => _showOptions(context, posts.indexOf(post)),
                  child: Icon(Icons.more_vert),
                ),
              ],
            ),
            SizedBox(height: 8),

            Text(
              post['created_at']?.substring(0, 10) ?? '',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 12),

            Text(post['text'] ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),

            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: const Color.fromARGB(255, 203, 76, 76),
                  size: 20,
                ),
                SizedBox(width: 4),
                Text('0'),
                SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.comment, size: 20),
                  onPressed: () =>
                      _showComments(context, post['id'].toString()),
                ),
                Spacer(),
                IconButton(
                  icon: Image.asset(
                    'assets/send.png',
                    width: 20,
                    height: 20,
                    color: Color.fromARGB(255, 114, 114, 114),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/save.png',
                    width: 20,
                    height: 20,
                    color: Color.fromARGB(255, 114, 114, 114),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showComments(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CommentSheet(postId: postId),
    );
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/create');
        break;
      case 2:
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(246, 246, 249, 1.0),
      currentIndex: _selectedIndex,
      onTap: _onNavBarTap,
      selectedItemColor: const Color.fromARGB(255, 28, 28, 28),
      unselectedItemColor: const Color.fromARGB(255, 9, 9, 9),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/home.png'),
            size: 24,
            color: const Color.fromARGB(255, 130, 129, 129),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/create.png'),
            size: 24,
            color: Colors.black,
          ),
          label: 'Create post',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/search.png'),
            size: 24,
            color: Colors.black,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/profile.png'),
            size: 24,
            color: Colors.black,
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text('Hi,  ${name}!'),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(239, 241, 244, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recent posts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return buildPostItem(posts[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}
