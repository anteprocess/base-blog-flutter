import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'DialogBox.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({
    this.auth,
    this.onSignedIn,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

//enum types in flutter
enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegisterPage> {
  //dialogbox
  DialogBox dialogBox = new DialogBox();


  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  //Methods

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  //add validation then submit
  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = "";
        if (_formType == FormType.login) {
          // Login user
          userId = await widget.auth.SignIn(_email, _password);
          dialogBox.information(context, "Logged in","Thank you for coming back!");
        } else {
          // Signup
          userId = await widget.auth.SignUp(_email, _password);
          dialogBox.information(context, "Signup complete","Thank you for signing up!");
        }
        if (userId != null) {
          widget.onSignedIn();
        }
      } catch (e) {
        dialogBox.information(context, "Error = ", e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Karate Blog for All"),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButton(),
            )),
      ),
    );
  }

  Widget logo() {
    return new Hero(
      tag: 'Hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset("images/test.png"),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 5.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Email"),
        validator: (value) {
          return value.isEmpty ? 'Email is required' : null;
        },
        onSaved: (value) {
          //assign the value of email
          return _email = value;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Password"),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'Password is required' : null;
        },
        onSaved: (value) {
          //assign the value of email
          return _password = value;
        },
      ),
      SizedBox(
        height: 10.0,
      )
    ];
  }

  List<Widget> createButton() {
    if (_formType == FormType.login) {
      return [
        // Login
        new RaisedButton(
            child: new Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: validateAndSubmit),

        new FlatButton(
            child: new Text(
              "Not have an account",
              style: TextStyle(fontSize: 10),
            ),
            textColor: Colors.white,
            color: Colors.lightGreen,
            onPressed: moveToRegister)
      ];
    } else {
      //Register
      return [
        new RaisedButton(
            child: new Text(
              "Register Account",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: validateAndSubmit),
        new FlatButton(
            child: new Text(
              "Already have an account",
              style: TextStyle(fontSize: 10),
            ),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: moveToLogin)
      ];
    }
  }
}
