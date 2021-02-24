//for File class
import 'package:flutter/material.dart';
//for PlatformException class
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:space/widgets/auth/auth_form.dart';

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
        FirebaseAuth.instance.currentUser.updateProfile(displayName: username);
        print(FirebaseAuth.instance.currentUser);
        return;
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(FirebaseAuth.instance.currentUser);
      return;
    } on FirebaseAuthException catch (err) {
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: AuthForm(_onAuthenticateUser),
    );
  }
}
