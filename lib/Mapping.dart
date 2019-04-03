import 'package:flutter/material.dart';
import 'package:karate_blog_flutter/LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Authentication.dart';

enum AuthStatus { notSignedIn, signedIn }

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;

  MappingPage({this.auth});

  @override
  State<StatefulWidget> createState() {
    return _MappingStatePage();
  }
}

class _MappingStatePage extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn; //State for the user: default

  //Initializing the state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId) {
      setState(() {
        authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }


  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    switch(authStatus) {
      case AuthStatus.notSignedIn:
        return LoginRegisterPage(
          auth: widget.auth,
          onSignedIn: _signedIn
        );

      case AuthStatus.signedIn:
        return HomePage(
            auth: widget.auth,
            onSignedOut: _signedOut
        );

    }
    return null;
  }
}
