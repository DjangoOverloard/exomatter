import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exom/homeFuncs.dart';

TextEditingController tagControl = new TextEditingController();
List<String> usedTags = [];

class PostCreation extends StatefulWidget {
  final inHero;

  const PostCreation({Key key, this.inHero}) : super(key: key);
  @override
  _PostCreationState createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  bool snackbaractive = false;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'postCreation',
      child: Material(
        color: Colors.white,
        borderRadius: widget.inHero
            ? BorderRadius.circular(0)
            : BorderRadius.circular(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 4),
                  blurRadius: 8),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[800],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(userDoc.data['nickname'].toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ))))),
                    ],
                  ),
                  widget.inHero
                      ? Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Post Title',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )))
                      : SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 45,
                        maxHeight: widget.inHero ? 90 : 45,
                      ),
                      child: TextField(
                        onTap: () {
                          if (!widget.inHero) {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => CreationHero(),
                            ));
                          }
                        },
                        readOnly: !widget.inHero,
                        maxLines: null,
                        maxLength: 200,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Want to write a post? Start from a title.'),
                      ),
                    ),
                  ),
                  widget.inHero
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('Short Description',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                constraints: BoxConstraints(
                                  minHeight: 45,
                                  maxHeight: 235,
                                ),
                                child: TextField(
                                  maxLength: 500,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          'Enter a short description for your activity'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('Tags',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              child: usedTags.length != 0
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Wrap(
                                          runSpacing: 10,
                                          spacing: 10,
                                          children: List.generate(
                                              usedTags.length, (index) {
                                            return Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: index == 0
                                                    ? Colors.blue
                                                    : index == 1
                                                        ? Colors.red
                                                        : Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(usedTags[index],
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              height: 1.0,
                                                            )),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              usedTags.remove(
                                                                  usedTags[
                                                                      index]);
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black38,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                    Icons
                                                                        .close,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 15),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })),
                                    )
                                  : SizedBox.shrink(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextField(
                                controller: tagControl,
                                onChanged: (val) {
                                  if (val.split(',').length == 2) {
                                    if (usedTags.indexWhere((d) =>
                                            d.toLowerCase() ==
                                            val
                                                .split(',')[0]
                                                .toLowerCase()) ==
                                        -1) {
                                      usedTags.add(val.split(',')[0]);
                                      setState(() {});
                                      tagControl.clear();
                                    } else {
                                      tagControl.clear();
                                      if (!snackbaractive) {
                                        snackbaractive = true;
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.blueGrey[900],
                                              content: Text(
                                                  'You either repeated the tag or entered the tag that doesnt exist.',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  )),
                                              action: SnackBarAction(
                                                label: 'OK',
                                                textColor: Colors.teal,
                                                onPressed: () {
                                                  Scaffold.of(context)
                                                      .hideCurrentSnackBar();
                                                },
                                              ),
                                            ))
                                            .closed
                                            .then((done) {
                                          snackbaractive = false;
                                        });
                                      }
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a comma separated tags',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Opacity(
                                opacity: 0.3,
                                child: Container(
                                  height: 45,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text('Send',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreationHero extends StatefulWidget {
  @override
  _CreationHeroState createState() => _CreationHeroState();
}

class _CreationHeroState extends State<CreationHero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Post Creation'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 200),
        child: PostCreation(
          //
          inHero: true,
        ),
      ),
    );
  }
}
