import 'package:flutter/material.dart';
import '../../services/auth.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Space'),
        backgroundColor: Colors.brown[400],
        //no drop shadow effect
        elevation: 0.0,
        actions: [
          FlatButton.icon(
            onPressed: () async {
              await _authService.signOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
