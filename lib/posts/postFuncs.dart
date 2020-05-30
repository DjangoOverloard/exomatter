import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../homeFuncs.dart';
import 'package:exom/posts/postPage.dart';

createPost(title, description, tags, context)async{
  showDialog(context: context, builder: (context)=>AlertDialog(
    content: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.teal),
    ),
  ));
  await Firestore.instance.collection('Posts').document().setData({
    'time': DateTime.now(),
    'title': title,
    'description': description, 
    'tags': tags,
    'userId': userDoc.documentID,
    'nickname': userDoc.data['nickname'], 
    'upvotes': [], 
    'downvotes': [],
    'repetitionReports': 0,   
  });
}

reportRepitition(doc, context)async{
  Navigator.pop(context);
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text('Reporting repetition'),
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.teal),
      ),
    ),
  ));
  await Firestore.instance.collection('Posts').document(doc.documentID).updateData({
    'repetitionReports': FieldValue.arrayUnion([userDoc.documentID]),
  });
}

deletePost(doc, context)async{
  Navigator.pop(context);
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text('Deleting Post'),
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.teal),
      ),
    ),
  ));
  await Firestore.instance.collection('Posts').document(doc.documentID).delete();
  Navigator.of(context).pop();
}

bool voting = false;
changeVote(isUpvote, doneCallback, doc)async{
  if(!voting){
  voting = true;
  var payload = {};
  if(isUpvote){
    bool isAddition = doc.data['upvotes'].indexWhere((g)=>g == doc.documentID) ==-1;
    bool downvoteExists = doc.data['downvotes'].indexWhere((g)=>g == doc.documentID)!=-1;
    payload = {
      'upvotes': isAddition?FieldValue.arrayUnion([doc.documentID]):
      FieldValue.arrayRemove([doc.documentID])
    };
    if(downvoteExists){
      payload['downvotes'] = FieldValue.arrayRemove([doc.documentID]);
    }
  }else{
  bool isAddition = doc.data['downvotes'].indexWhere((g)=>g == doc.documentID) ==-1;
    bool upvoteExists = doc.data['upvotes'].indexWhere((g)=>g == doc.documentID)!=-1;
    payload = {
      'downvotes': isAddition?FieldValue.arrayUnion([doc.documentID]):
      FieldValue.arrayRemove([doc.documentID])
    };
    if(upvoteExists){
      payload['upvotes'] = FieldValue.arrayRemove([doc.documentID]);
    }
  }
  await Firestore.instance.collection('Posts').document(doc.documentID).updateData(payload);
  voting = false;
  doneCallback();
  }
}

bool fetching = false;
fetchPosts(fetchedCallback, fetchedPosts)async{
  if(!fetching){
    fetching = true;
    final query = posts.length!=0?Firestore.instance.collection('Posts').limit(5)
    .orderBy('time', descending: true).startAfterDocument(posts.last)
    :Firestore.instance.collection('Posts').limit(5).orderBy('time', descending: true);
    await query.getDocuments().then((value) => (qs){
      if(qs.documents.length!=0 && !fetchingNew){
      posts.addAll(qs.documents);
      }
      fetchedPosts(qs.documents);
    });
    fetching = false;
  }
}
bool fetchingNew = false;
fetchNewPosts(fetchedCallback)async{
  if(!fetchingNew){
  fetchingNew = true;
  await fetchPosts((){}, (val){
    if(val.length == 10){
      posts.clear();
    }
    posts.insertAll(0, val);
  });
    fetchedCallback();
  fetchingNew = false;
  }
}

bool showNewPostsButton = false;
checkNewPosts(callback)async{
  final query = posts.length!=0?Firestore.instance.collection('Posts')
  .limit(1).startAfterDocument(posts.first).orderBy('time'):
  Firestore.instance.collection('Posts').limit(1);
  await query.getDocuments().then((qs){
    if(qs.documents.length!=0){
      showNewPostsButton = true;
      callback();
    }
  });
}