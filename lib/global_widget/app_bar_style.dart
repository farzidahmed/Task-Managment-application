// note: jodi ami custom appbar use korte cai tahole amr
//appbar class a PreferredSizeWidget korte hobe..
// and stateke stateless widget a convert korte hobe

//PreferredSizeWidget ke AppBar er khetre use korte hoy karon AppBar er ekta fixed height thake,
// ar Scaffold er appBar property sudhu sei widget gulo kei accept kore, jara explicitly tader size define kore.
// Flutter er AppBar class already PreferredSizeWidget ke inherit kore,
// jate tar height automatically define kora thake.

import 'package:flutter/material.dart';
import 'package:task_managment/utills/apps_colors.dart';
import 'package:task_managment/views/Auth_screen/sign_in_screen.dart';

class AppBarStyle extends StatelessWidget implements PreferredSizeWidget {
  const AppBarStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        backgroundColor: Appscolor.themecolor,
        title: Padding(
          padding: const EdgeInsets.only(left:10.0),
          child: Row(
            children: [
               CircleAvatar(
                radius: 20,
              // backgroundImage: Image.asset("assets/images/rimon.jpg"),
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 20,),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Farzid Ahmed",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                    Text("rimonraj670@gmail.com",style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ],
                ),
              ),
              IconButton(onPressed:(){
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context)=> SignInScreen()),(value)=>false);
              },
                  icon: const Icon(Icons.logout,color: Colors.white,))
            ],
          ),
        ),
      );
  }
  //
  // void _buidLogoutButton(){
  //   //TODO: implement logout button next
  //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignInScreen()),(value)=>false);
  // }


  @override
  // TODO: implement preferredSize

  // note : ktoolbar keno use kora hoy,?
  // default appbar er height ke reprsent kore...
  Size get preferredSize =>const Size.fromHeight(kToolbarHeight ) ;
}
