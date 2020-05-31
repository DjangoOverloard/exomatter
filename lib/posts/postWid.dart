import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/homeFuncs.dart';
import 'package:exom/posts/postFuncs.dart';
import 'package:exom/posts/postPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostWid extends StatefulWidget {
  final actionUnavailable;
  final update;
  final doc;

  const PostWid({Key key, this.doc, this.update, this.actionUnavailable})
      : super(key: key);
  @override
  _PostWidState createState() => _PostWidState();
}

class _PostWidState extends State<PostWid> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double w = MediaQuery.of(context).size.width;
    bool isVoting = voteLoading != ''
        ? voteLoading.split(', ')[1] == widget.doc.documentID
        : false;
    bool isUpvote = isVoting ? voteLoading.split(', ')[0] == '1' : null;
    var links = widget.doc.data['images'];
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.doc.data['spaceOrganization'] == null
                ? Text(
                    '${widget.doc.data['nickname']}',
                    style: textTheme.caption,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('By:'),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SizedBox(
                          height: 10,
                          child: Image(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                                'assets/${widget.doc.data['spaceOrganization']}.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 4.0),
            Text(
              '${widget.doc.data['title']}',
              style: textTheme.headline6,
            ),
            SizedBox(height: 4.0),
            Text(
              '${widget.doc.data['description']}',
              style: textTheme.subtitle1,
            ),
            SizedBox(height: 12.0),
            Wrap(
              runSpacing: 10,
              children: List.generate(
                links.length,
                (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: (index + 1).isOdd ? 10 : 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text('Image view'),
                            ),
                            backgroundColor: Colors.black,
                            body: Center(
                              child: Image(
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  links[index],
                                ),
                              ),
                            ),
                          ),
                        ));
                      },
                      child: Container(
                        width: (w - 42) / 2,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Center(
                            child: Image(
                              height: 100,
                              width: (w - 26) / 2,
                              fit: BoxFit.cover,
                              image: NetworkImage(links[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'Links',
              style: textTheme.caption,
            ),
            Column(
              children: List.generate(widget.doc.data['links'].length, (index) {
                return InkWell(
                  child: Text(widget.doc.data['links'][index],
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      )),
                  onTap: () {
                    _launchURL(widget.doc.data['links'][index], context);
                  },
                );
              }),
            ),
            SizedBox(height: 12.0),
            Text(
              'Tag',
              style: textTheme.caption,
            ),
            Chip(
              backgroundColor: Colors.teal,
              label: Text(
                widget.doc.data['tag'],
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 12.0),
            Divider(
              height: 0.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 36.0,
                    height: 36.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () {
                        changeVote(true, () {
                          if (mounted) {
                            widget.update();
                          }
                        }, widget.doc);
                      },
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '${widget.doc.data['upvotes'].length}',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      height: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  (isUpvote != null ? isUpvote : false)
                      ? Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Container(
                              height: 15,
                              width: 15,
                              child: Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.teal)),
                              )),
                        )
                      : SizedBox.shrink(),
                  SizedBox(width: 4.0),
                  SizedBox(
                    width: 36.0,
                    height: 36.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () {
                        changeVote(false, () {
                          widget.update();
                        }, widget.doc);
                      },
                    ),
                  ),
                  Text(
                    '${widget.doc.data['downvotes'].length}',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      height: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  (isUpvote != null ? !isUpvote : false)
                      ? Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Container(
                              height: 15,
                              width: 15,
                              child: Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.teal)),
                              )),
                        )
                      : SizedBox.shrink(),
                  Spacer(),
                  widget.actionUnavailable == null &&
                          widget.doc.data['cantMakeActions'] == null
                      ? SizedBox(
                          width: 36.0,
                          height: 36.0,
                          child: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  bool isYourPost = widget.doc.data['userId'] ==
                                      userDoc.documentID;
                                  return Container(
                                    height: 100,
                                    width: double.maxFinite,
                                    color: Colors.white,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: double.maxFinite,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Choose the action',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  )),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DeleteOrReport(
                                                        doc: widget.doc,
                                                        typeDelete: isYourPost,
                                                      )).then((value) {
                                                widget.update();
                                              });
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 50,
                                              width: double.maxFinite,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                      isYourPost
                                                          ? 'Delete'
                                                          : 'Report repitition',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      )),
                                                  Spacer(),
                                                  Icon(
                                                      isYourPost
                                                          ? Icons.delete
                                                          : Icons.warning,
                                                      color: isYourPost
                                                          ? Colors.red
                                                          : Colors.orange,
                                                      size: 25),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL(url, context) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Scaffold.of(context).showSnackBar(new SnackBar(
      backgroundColor: Colors.teal,
      content: Text('Could not launch url.'),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {
          Scaffold.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
}

class DeleteOrReport extends StatefulWidget {
  final bool typeDelete;
  final DocumentSnapshot doc;
  final update;

  const DeleteOrReport({Key key, this.typeDelete, this.doc, this.update})
      : super(key: key);
  @override
  _DeleteOrReportState createState() => _DeleteOrReportState();
}

class _DeleteOrReportState extends State<DeleteOrReport> {
  send() async {
    if (sent == null) {
      sent = false;
      setState(() {});
      var path = Firestore.instance
          .collection('Posts')
          .document(widget.doc.documentID);
      if (widget.typeDelete) {
        await path.delete();
      } else {
        await path.updateData({
          'repetitionReports': FieldValue.arrayUnion([userDoc.documentID]),
        });
      }
      sent = true;
      setState(() {});
    }
  }

  bool sent;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: sent == null
          ? AlertDialog(
              title: Text(
                widget.typeDelete
                    ? 'Are you sure you want to delete this post?'
                    : 'Are you sure you want to report the repitition?',
              ),
              actions: <Widget>[
                FlatButton(
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                      child: Text('No',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ))),
                ),
                FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    send();
                  },
                  child: Center(
                    child: Text('Yes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ),
                ),
              ],
            )
          : !sent
              ? AlertDialog(
                  title: Text('Processing'),
                  content: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.teal),
                    ),
                  ),
                )
              : AlertDialog(
                  title: Text('Done!'),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.teal,
                      child: Center(
                        child: Text('Ok',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (widget.typeDelete) {
                          posts.remove(widget.doc);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
    );
  }
}
