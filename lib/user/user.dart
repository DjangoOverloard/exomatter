import 'package:flutter/material.dart';

import '../homeFuncs.dart';

class UserBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
          children: [
            Container(
              height: 100, width: 100, 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal, 
              ),
              child: Center(
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('${userDoc.data['nickname']}', style: TextStyle(
                fontSize: 22, color: Colors.teal,
              )),
            ),
          ],
        ),
      ),
    );
  }
}