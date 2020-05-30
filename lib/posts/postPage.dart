import 'package:exom/posts/postCreation.dart';
import 'package:exom/posts/postWid.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'postFuncs.dart';
import 'dart:async';

List<DocumentSnapshot> posts = [];

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ScrollController scr = new ScrollController();
  Timer updateTimer;

  scrListener() async {
    final pos = scr.position.pixels;
    final max = scr.position.maxScrollExtent;
    if (max - pos < 400) {
      fetchPosts(() {
        if (mounted) {
          setState(() {});
        }
      }, (val) {}, false);
    }
  }

  updateListener() {
    print('updating the listener');
    updateTimer = new Timer(Duration(minutes: 1), () async {
      await checkNewPosts(() {
        if (mounted) {
          setState(() {});
        }
      });
      updateListener();
    });
  }

  @override
  void initState() {
    if (posts.length == 0) {
      fetchPosts(() {
        if (mounted) {
          setState(() {});
        }
      }, (val) {}, true);
    } else {
      checkNewPosts(() {
        if (mounted) {
          setState(() {});
        }
      });
    }
    updateListener();
    scr.addListener(() {
      scrListener();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.separated(
          controller: scr,
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: posts.length + 2,
          itemBuilder: (context, index) {
            return index != 0
                ? index != posts.length + 1
                    ? PostWid(
                        doc: posts[index - 1],
                      )
                    : Container(
                        height: 200,
                        width: double.maxFinite,
                        child: Center(
                          child: Text('There are no other posts',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        ),
                      )
                : PostCreation(
                    inHero: false,
                  );
          },
          separatorBuilder: (context, i) => SizedBox(
            height: 8.0,
          ),
        ),
        AnimatedPositioned(
          top: showNewPostsButton ? 10 : -40,
          left: 0,
          right: 0,
          duration: Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () {
              scr.animateTo(0,
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 300));
              showNewPostsButton = false;
              setState(() {});
              fetchNewPosts(() {
                if (mounted) {
                  setState(() {});
                }
              });
            },
            child: Center(
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0.0, 1.0)),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text('New Posts Available!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
