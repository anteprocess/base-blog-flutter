import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Package and the class that will be using firebase and will hold the method to handle the
// User information

abstract class AuthImplementation {
  Future<String> SignIn(String email, String password);
  Future<String> SignUp(String email, String password);
  Future<void> signOut();
  Future<String> getCurrentUser();
}

class Auth implements AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Create user id
  Future<String> SignUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  // Sign in
  Future<String> SignIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  //Sign out
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  //Get the user id
  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }
}
