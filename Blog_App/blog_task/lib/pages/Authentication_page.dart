

import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget{
  const AuthenticationPage({super.key});
  State <AuthenticationPage>createState()=>_AuthenticationPage();
}
class _AuthenticationPage extends State<AuthenticationPage>{
    double res=0;
    final TextEditingController controller=TextEditingController();


    Widget build(BuildContext context){
    
    return  Scaffold(
      backgroundColor: Color.fromRGBO(239, 241, 244,1),
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
            //color: Colors.red,
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
                          Image.asset('assets/logo.png',height: 70,width:50,fit:BoxFit.contain),
                          SizedBox(height: 0,width: 100,),
                          Text(
                            "appreciate",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              letterSpacing: 0
                            ),
                          
                          )
                        ],
                      ),
                      
                    ),
                  ),
                  
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                // color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(    
                           
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Let’s go!",
                      
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
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                  )
                ),
                SizedBox(height: 30,),
                
                Container(
                  
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Text(
                            "Enter user name",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      //  SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "eg. John Doe",
                            ),
                          ),
                        )
                      ],
                    )
                    ),
                  ),
                ),
                SizedBox(height: 10),
                
          
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Text(
                            "Enter Password",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      //  SizedBox(height: 5,)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "eg. password",
                            ),
                          ),
                        )
                      ],
                    )
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Color.fromRGBO(4,97,229,1),
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                        ),
                    ),
                  ),
                ),
          
          
                const SizedBox(height: 8),
          
               
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(4,97,229,1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
          
          
                const SizedBox(height: 16),
          
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? ",style: TextStyle(
                      fontSize: 17
                    ),),
                    const Text(
                      "sign up",
                      style: TextStyle(
                       color:  Color.fromRGBO(4,97,229,1),
                        fontSize: 17),
                    )
                  ],
                ),
          
          
              ],
             )
          
          ),
        ),
      ),
    ),
  ],
),

      
    );
  }
}
