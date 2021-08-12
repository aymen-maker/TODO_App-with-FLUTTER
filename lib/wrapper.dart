import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'FirstScreen.dart';
import 'user.dart';
import 'auth.dart';




class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //final userG = Provider.of<User>(context);
      if (user==null){
        return LoginPage();
      }
      else {
        return MainPage();
      }


  }
}