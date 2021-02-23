import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home/homeScreen.dart';
import './authentication/authenticationScreen.dart';

//Wrapper listens for authentication changes
//Depending on whether user is authenticated or not, it returns either HomeScreen() or AuthenticationScreen()
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Whenever there is a stream change, User updates, and all values referring to Provider.of<user> will rerender
    final user = Provider.of<FirebaseUser>(context);
    return user == null ? AuthenticationScreen() : HomeScreen();
  }
}
