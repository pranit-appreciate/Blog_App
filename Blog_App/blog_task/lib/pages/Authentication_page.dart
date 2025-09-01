import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isFieldError = false;
  String _responseMessage = '';
 
Future<void> registerUser() async {
  final username = _nameController.text.trim();
  final password = _passwordController.text.trim();

  if (username.isEmpty || password.isEmpty) {
    setState(() {
      _isFieldError = true;
      _responseMessage = 'All fields are required.';
    });
    return;
  }

  setState(() {
    _isFieldError = false;
    _responseMessage = '';
  });

  try {
    final response = await http.post(
      Uri.parse('https://miniblog-backend-osjz.onrender.com/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    final data = jsonDecode(response.body);

    setState(() {
      _responseMessage = data['message'];
    });

    if (response.statusCode == 200 && data['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
     await prefs.setString('token', data['token']);
     await prefs.setString('name',data['username']);
      Navigator.pushReplacementNamed(context, '/home'); 
    }
  } catch (e) {
    setState(() {
      _responseMessage = 'Error: $e';
    });
  } finally {
    setState(() {
      print(_responseMessage);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 241, 244, 1),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Container(
                  height: 724,
                  width: 400,
                  child: Column(
                    children: [
                   
                      Container(
                        height: 150,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/logo.png',
                                    height: 70,
                                    width: 50,
                                    fit: BoxFit.contain),
                                const Text(
                                  "appreciate",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 22,
                                      letterSpacing: 0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                   
                      Container(
                        height: 100,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Let’s go!",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Please enter your credentials to log in',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

            
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Enter user name",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "eg. John Doe",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      
                      Container(
                        constraints: BoxConstraints(minHeight: 110),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: _isFieldError
                              ? Border.all(color: Colors.red, width: 2)
                              : Border.all(color: Colors.transparent),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Enter Password",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "eg. password",
                                  ),
                                ),
                              ),
                              if (_isFieldError)
                                const Padding(
                                  padding: EdgeInsets.only(top: 5, left: 15),
                                  child: Text(
                                    "Please enter correct password",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Color.fromRGBO(4, 97, 229, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(4, 97, 229, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: registerUser,
                          child:const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Don’t have an account? ",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "sign up",
                            style: TextStyle(
                                color: Color.fromRGBO(4, 97, 229, 1),
                                fontSize: 17),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
