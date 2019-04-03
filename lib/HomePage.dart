import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'DialogBox.dart';
import 'Mapping.dart';
import 'Authentication.dart';

// create new Widget
class HomePage extends StatefulWidget {
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  HomePage({this.auth, this.onSignedOut});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

// Create new State
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "Home Page",
          textAlign: TextAlign.center,
        ),
      ),
      //This is for the posts
      body: new Container(),

      bottomNavigationBar: new BottomAppBar(
        color: Colors.lightBlue,
        child: new Container(
          margin: const EdgeInsets.only(left: 70.0, right: 70.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              new IconButton(
                  icon: new Icon(Icons.local_car_wash),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: _logoutUser),
              new IconButton(
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: null),
              new IconButton(
                  icon: new Icon(Icons.local_car_wash),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: null)
            ],
          ),
        ),
      ),
    );
  }

  // method
  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      DialogBox dialogBox = new DialogBox();
      dialogBox.information(context, "Logged out","See you soon!");
      widget.onSignedOut();
    } catch (e) {}
  }
}
