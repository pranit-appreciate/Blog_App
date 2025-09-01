import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String? name='';
  int _selectedIndex=3;

  @override
  void initState() {
    getName();
    super.initState();
  }

    void getName()async{
      final prefs = await SharedPreferences.getInstance();
    String? fetchedName = prefs.getString('name');
    print(name);
    setState(() {
      name=fetchedName;
    });
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
    
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Hi, ${name}'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: Container(
        color: Color.fromRGBO(246, 246, 249, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20),
                    child: Column(
                      spacing: 0,
                      children: [
                        InkWell(
                          onTap: (){},
                          child:Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //making some changes 
                            child: Row(
                              children: [
                                Image.asset('assets/person.png',height: 50,width: 50,),
                                
                                Text('My Profile',style: TextStyle(
                                  fontSize: 18
                                ),),
                                Spacer(),
                                Image.asset('assets/go.png'),
                                
                              ],
                            )
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: (){},
                          child:Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            
                            child: Row(
                              children: [
                                Image.asset('assets/changepass.png',height: 50,width: 50,),
                                
                                Text('Change Password',style: TextStyle(
                                  fontSize: 18
                                ),),
                                Spacer(),
                                Image.asset('assets/go.png'),
                                
                              ],
                            )
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: (){},
                          child:Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //making some changes 
                            child: Row(
                              children: [
                                Image.asset('assets/settings.png',height: 50,width: 50,),
                                
                                Text('Settings & Preferences',style: TextStyle(
                                  fontSize: 18
                                ),),
                                Spacer(),
                                Image.asset('assets/go.png'),
                                
                              ],
                            )
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: (){},
                          child:Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //making some changes 
                            child: Row(
                              children: [
                                Image.asset('assets/support.png',height: 50,width: 50,),
                                
                                Text('Support',style: TextStyle(
                                  fontSize: 18
                                ),),
                                Spacer(),
                                Image.asset('assets/go.png'),
                                
                              ],
                            )
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: (){},
                          child:Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //making some changes 
                            child: Row(
                              children: [
                                Image.asset('assets/aboutus.png',height: 50,width: 50,),
                                Image.asset('assets/people.png',height: 50,width: 50,),
                                Text('About us',style: TextStyle(
                                  fontSize: 18
                                ),),
                                Spacer(),
                                Image.asset('assets/go.png'),
                                
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              
              SizedBox(height: 20,), 
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('token');
                    await prefs.remove('name');
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    minimumSize: Size(double.infinity, 72),
                    iconColor: const Color.fromARGB(255, 11, 11, 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Image.asset('assets/logout.png'),
                      Text('Log out',style: TextStyle(
                        color: Colors.black,
                        fontSize:18,
                        fontWeight: FontWeight.w400
                      ),),
                      Spacer(),
                      Image.asset('assets/go.png')
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              Center(
                child: Text(
                  'Version 1.162',
                  style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 126, 126, 126)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
     currentIndex: _selectedIndex,
     onTap: _onNavBarTap,
      selectedItemColor: const Color.fromARGB(255, 28, 28, 28),
      unselectedItemColor: const Color.fromARGB(255, 9, 9, 9),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/home.png'),
          size: 24,
          color: const Color.fromARGB(255, 130, 129, 129),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/create.png'),
          size: 24,
          color: Colors.black,
          ),
          label: 'Create post',
          
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/search.png'),
          size: 24,
          color: Colors.black,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/profile.png'),
          size: 24,
          color: Colors.black,
          ),
          label: 'Profile',
        ),
      ],
      ),
    );
  }
}
//MAKING CHANGES IN PAGE
