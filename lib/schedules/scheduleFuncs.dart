import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/schedules/schedule_page.dart';


bool voting = false;
var voteScheduleLoading = '';
changeVote(isUpvote, doneCallback, doc) async {
  if (!voting) {
    voting = true;
    var payload;
    if (isUpvote) {
      bool isAddition =
          doc.data['upvotes'].indexWhere((g) => g == doc.documentID) == -1;
      bool downvoteExists =
          doc.data['downvotes'].indexWhere((g) => g == doc.documentID) != -1;
      payload = {
        'upvotes': isAddition
            ? FieldValue.arrayUnion([doc.documentID])
            : FieldValue.arrayRemove([doc.documentID])
      };
      if (downvoteExists) {
        payload['downvotes'] = FieldValue.arrayRemove([doc.documentID]);
      }
    } else {
      bool isAddition =
          doc.data['downvotes'].indexWhere((g) => g == doc.documentID) == -1;
      bool upvoteExists =
          doc.data['upvotes'].indexWhere((g) => g == doc.documentID) != -1;
      payload = {
        'downvotes': isAddition
            ? FieldValue.arrayUnion([doc.documentID])
            : FieldValue.arrayRemove([doc.documentID])
      };
      if (upvoteExists) {
        payload['upvotes'] = FieldValue.arrayRemove([doc.documentID]);
      }
    }
    voteScheduleLoading = '${isUpvote ? 1 : 0}, ${doc.documentID}';
    doneCallback();
    await Firestore.instance
        .collection('Schedules')
        .document(doc.documentID)
        .updateData(payload);
    await Firestore.instance
        .collection('Schedules')
        .document(doc.documentID)
        .get()
        .then((ds) {
      schedules[schedules.indexWhere((d) => d.documentID == ds.documentID)] = ds;
    });
    voting = false;
    voteScheduleLoading = '';
    doneCallback();
  }
}