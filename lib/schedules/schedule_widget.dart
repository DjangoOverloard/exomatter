import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/posts/postPage.dart';
import 'package:exom/posts/postWid.dart';
import 'package:exom/schedules/scheduleFuncs.dart';
import 'package:exom/widgets/container.dart';
import 'package:exom/widgets/indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  final DocumentSnapshot doc;
  final update;

  const ScheduleWidget({Key key, this.doc, this.update}) : super(key: key);
  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

Color _getIndexColor(double p) => Color.lerp(Colors.green, Colors.blue, p);

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
      bool isVoting = voteScheduleLoading!=''?voteScheduleLoading.split(', ')[1] == widget.doc.documentID:false;
    bool isUpvote = isVoting?voteScheduleLoading.split(', ')[0] == '1':null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
                  child: ExContainer(
              width: double.infinity,
              height: 75.0,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IndicatorWidget(
                    isActive: true,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Today',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          '${widget.doc.data['tagNames'].length} Activities',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_upward,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      changeVote(true, (){
                        setState((){});
                        widget.update();
                      }, widget.doc);
                    },
                  ),
                   Text(
                  '${widget.doc.data['upvotes'].length}',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                  (isUpvote!=null?isUpvote:false)?Padding(
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
                ):SizedBox.shrink(),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_downward,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      changeVote(false, (){
                        setState((){});
                        widget.update();
                      }, widget.doc);
                    },
                  ),
                   Text(
                  '${widget.doc.data['downvotes'].length}',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                  (isUpvote!=null?!isUpvote:false)?Padding(
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
                ):SizedBox.shrink(),
                ],
              ),
            ),
        ),
        ...(widget.doc.data['activities'] as List).map(
          (activity) {
            final textTheme = Theme.of(context).textTheme;

            final int index = widget.doc.data['activities'].indexOf(activity);
            final String tag = widget.doc.data['tagNames'][index];
            final String credit =
                widget.doc.data['links'][index == 6 ? 5 : index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ExContainer(
                indicatorColor: _getIndexColor(index / widget.doc.data['activities'].length),
                width: double.infinity,
                height: 70,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tag.substring(0, 1)[0].toUpperCase() +
                                tag.substring(1),
                            style: textTheme.caption.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            activity,
                            style: textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                      height: 36.0,
                      child: IconButton(
                        icon: Icon(Icons.link),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context)=> IndividualPost(
                              docid: widget.doc.data['links'][index],
                            ),
                          ));
                        },
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}



retDat(date) {
  return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}';
}



class IndividualPost extends StatefulWidget {
  final docid;

  const IndividualPost({Key key, this.docid}) : super(key: key);
  @override
  _IndividualPostState createState() => _IndividualPostState();
}

class _IndividualPostState extends State<IndividualPost> {

  DocumentSnapshot doc;

  getDoc()async{
    await Firestore.instance.collection('Posts').document(widget.docid).get().then((ds){
      posts.add(ds);
      doc = ds;
    });
    if(mounted){
      setState((){});
    }
    print('got the doc from docs, this is the docid');
  }


  @override
  void initState() {
    var ind = posts.indexWhere((d)=>d.documentID == widget.docid);
    if(ind!= -1){
      doc = posts[ind];
      setState((){});
    }else{
      getDoc();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Post'),
      ),
      body: doc!=null?SingleChildScrollView(
        child: PostWid(
          actionUnavailable: true,
          doc: doc,
          update: (){
            var ind = posts.indexWhere((d)=>d.documentID == widget.docid);
             doc = posts[ind];
            if(mounted){
              setState((){});
            }
          },
        ),
      ):SizedBox.shrink(),
    );
  }
}