import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

//Authservice defines a bunch of methods we use to interact with Firebase
class AuthService {
  //creating an instance of FirebaseAuth to interact with firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on returned FirebaseUser
  User _createUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      //if successful in login, Firebase returns an object
      AuthResult result = await _auth.signInAnonymously();
      //the user property of the object points ot an object
      FirebaseUser user = result.user;
      return _createUser(user);
    } catch (err) {
      print(err.toString());
    }
  }

  //getter for user onAuthStateChanged stream
  //onAuthStateChange returns a FirebaseUser object, but we want to work
  //with our own User object
  Stream<User> get userStream {
    return _auth.onAuthStateChanged
        //.onAuthStateChanged returns a FirebaseUser object each time
        //the user logs in or out
        //since we are working with our custom User object, we must map it
        //.map((FirebaseUser user)=>_createUser(user)); shortform:
        .map(_createUser);
  }

  //sign in with email and password
  Future signIn({email, password}) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    return _createUser(user);
  }

  //register with email and password
  Future register({email, password}) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    return _createUser(user);
  }

  //sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print(err.toString());
    }
  }
}
