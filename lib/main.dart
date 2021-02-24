import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/home/home_screen.dart';
import './screens/splash_screen.dart';
import './screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return StreamProvider<User>.value(
            value: FirebaseAuth.instance.authStateChanges(),
            child: MaterialApp(
              theme: ThemeData(),
              home: Wrapper(),
            ),
          );
        },
      ),
    );
  }
}
