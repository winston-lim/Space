//for File class
import 'package:flutter/material.dart';
//for PlatformException class
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/auth/authForm.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  var _isLoading = false;
  final fallbackErrorMessage =
      'An error occurred, please check your credentials!';

  Future<void> _onAuthenticateUser(
    String email,
    String password,
    String username,
    bool isUserLoggedIn,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (!isUserLoggedIn) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return;
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return;
    } on PlatformException catch (err) {
      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.message ?? fallbackErrorMessage),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[100],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: AuthForm(_onAuthenticateUser),
    );
  }
}
