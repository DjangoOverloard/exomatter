import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exom/homeFuncs.dart';


class Authorization extends StatefulWidget {
  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  var email = '';
  var password = '';
  var nickname = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Icon(Icons.assignment, color: Colors.teal,size: 50),
          ),
          Text('Exotic Matter', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal, fontSize: 24, 
          )),
          Padding(
            padding: EdgeInsets.only(top: 10),
                      child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index){
                return defContainer(index);
              })
            ),
          ),
        ],
      ),
    );
  }

  enterTheSystem()async{
    email = email.toLowerCase();
    showDialog(context: context, builder:(context)=>AlertDialog(
      title: Text('Entering the system'),
      content: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.teal),
      ),
    ));
    final userDoc = await Firestore.instance.collection('Users')
    .where('email', isEqualTo:email.toLowerCase()).limit(1).getDocuments();
    if(userDoc.documents.length == 0){
    await Firestore.instance.collection('Users').document().setData({
      'nickname': nickname,
      'email': email, 
      'registeredAt': DateTime.now(),
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: '$email',
    password: '$password');
    await getUserDoc();
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      maintainState: true, 
      builder: (context)=> HomePage(),
    ));
    }else{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: '$email',
    password: '$password')
    .then((value)async{
      await getUserDoc();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        maintainState: true,
        builder: (context)=> HomePage(),
      ));
    }).catchError((error){
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(
        title: Text(error.toString()),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            color: Colors.teal,
            child: Center(
              child: Text('Retry', style: TextStyle(
                color: Colors.white, 
              )),
            ),
          ),
        ],
      ));
    });
    }
  }

  checkEverything(){
    var ret = true;
    if(nickname.length == 0){
      ret = false;
    }
    if(password.length == 0){
      ret = false;
    }
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email)){
      ret = false;
    }
    return ret;
  }
  var correct = false;
  Widget defContainer(index){
    return Padding(
      padding: EdgeInsets.only(top: index!=0?10:0, left: 10, right: 10),
          child: GestureDetector(
            onTap: (){
              if(index ==3){
                if(checkEverything()){
                enterTheSystem();
                }
              }
            },
           child: Opacity(
            opacity: index !=3?1.0:(checkEverything()?1.0:0.3),
                                              child: Container(
        height: 45, 
        width: double.maxFinite,
        decoration: BoxDecoration(
            color:index!=3? Colors.white:Colors.teal, 
            borderRadius: BorderRadius.circular(5), 
            boxShadow: [
              BoxShadow(
                 color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 4),
                    blurRadius: 8,
              ),
            ],
        ),
        child: index!=3?Padding(
            padding: EdgeInsets.only(left: 5,right: 5),
            child: TextField(
              obscureText: index == 2,
              onChanged: (value){
                var val = value.trim();
                if(index == 0){nickname = val;}
                else if(index == 1){email = val;}
                else{password = val;}
                if(checkEverything() && !correct){
                  correct = true;
                  setState((){});
                }
                if(!checkEverything() && correct){
                  correct = false;
                  setState((){});
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: index == 0?'Nickname':index == 1?'Email':'Password', 
              ),
            ),
        ):Center(
            child: Text('Log-In', style: TextStyle(
              color: Colors.white, fontSize: 18, 
            )),
        ),
      ),
                      ),
          ),
    ); 
  }
}