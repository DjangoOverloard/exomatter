import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/home.dart';
import 'package:exom/widgets/container.dart';
import 'package:exom/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exom/homeFuncs.dart';

class Authorization extends StatefulWidget {
  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController nicknameController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nicknameController = TextEditingController();

    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    nicknameController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.assignment, color: Colors.teal, size: 50),
              ),
              Text(
                'Exotic Matter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16.0),
              ExContainer(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExTextField(
                      controller: nicknameController,
                      icon: Icons.person,
                      hint: 'Username',
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.0),
                      ),
                    ),
                    Divider(),
                    ExTextField(
                      controller: emailController,
                      icon: Icons.alternate_email,
                      hint: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      borderRadius: BorderRadius.zero,
                    ),
                    Divider(),
                    ExTextField(
                      controller: passwordController,
                      icon: Icons.lock,
                      hint: 'Password',
                      obscureText: true,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: RaisedButton.icon(
                  icon: Icon(Icons.chevron_right),
                  label: Text('Sign in'),
                  textColor: Colors.white,
                  onPressed: checkEverything() ? enterTheSystem : null,
                  color: Colors.teal,
                  disabledColor: Colors.teal.withOpacity(0.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  enterTheSystem() async {
    final email = emailController.text.toLowerCase();
    final nickname = nicknameController.text;
    final password = passwordController.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Entering the system'),
        content: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.teal),
        ),
      ),
    );

    final userDoc = await Firestore.instance
        .collection('Users')
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .getDocuments();
    if (userDoc.documents.length == 0) {
      await Firestore.instance.collection('Users').document().setData({
        'nickname': nickname,
        'email': email,
        'registeredAt': DateTime.now(),
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: '$email', password: '$password');
      await getUserDoc();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        maintainState: true,
        builder: (context) => HomePage(),
      ));
    } else {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: '$email', password: '$password')
          .then((value) async {
        await getUserDoc();
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          maintainState: true,
          builder: (context) => HomePage(),
        ));
      }).catchError(
        (error) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.teal,
                  child: Center(
                    child: Text('Retry',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  checkEverything() {
    if (nicknameController.text.length == 0) {
      return false;
    }
    if (passwordController.text.length == 0) {
      return false;
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(emailController.text)) {
      return false;
    }

    return true;
  }
}
