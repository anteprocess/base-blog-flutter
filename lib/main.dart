import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Mapping.dart';
import 'Authentication.dart';

void main() {
  runApp(new BlogApp());
}

// the main blogapp
class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Vegan Blog 4 All",
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      home: MappingPage(auth: Auth()),
    );
  }

}