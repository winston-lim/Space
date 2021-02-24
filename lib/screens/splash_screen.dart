import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[20],
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }
}
