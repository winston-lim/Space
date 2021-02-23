//for File class
import 'dart:io';
import 'package:flutter/material.dart';
//for PlatformException class
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../widgets/auth/authForm.dart';
import '../../services/auth.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final AuthService _authService = AuthService();
  var _isLoading = false;
  //define methods here to keep functions separate from form widget
  //submit form method
  Future _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _authService.signIn(
          email: email,
          password: password,
        );
      } else {
        authResult = await _authService.register(
          email: email,
          password: password,
        );
        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child('user_image')
        //     .child(authResult.user.uid + '.jpg');

        // await ref.putFile(image).onComplete;

        // final url = await ref.getDownloadURL();

        // await Firestore.instance
        //     .collection('users')
        //     .document(authResult.user.uid)
        //     .setData({
        //   'username': username,
        //   'email': email,
        //   'image_url': url,
        // });
        return authResult;
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        // err.message contains formatted readable error message from FirebaseAuth
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
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
      body: AuthForm(),
    );
  }
}
