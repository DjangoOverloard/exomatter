import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/schedules/scheduleWid.dart';
import 'package:flutter/material.dart';



List<DocumentSnapshot> schedules = [];
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var moreAvailable = true;
  var fetching = false;
  bool ready = false;
  ScrollController scr = new ScrollController();

  getSchedules()async{
    if(!fetching && moreAvailable){
    fetching = true;
    var query = Firestore.instance.collection('Schedules').orderBy('time', descending: true);
    await (schedules.length!=0?query.startAfterDocument(schedules.last):query).limit(5).getDocuments().then((qs){
      if(qs.documents.length!=0){
      schedules.addAll(qs.documents);
      }
      moreAvailable = qs.documents.length == 5;
    });
    fetching = false;
    if(!ready){
      ready = true;
      setState((){});
    }
    }
  }

  @override
  void initState() {
    getSchedules();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ready?ListView.builder(
      itemCount: schedules.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index){
      return ScheduleWid(
        doc: schedules[index],
      );
    }):Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.teal),
      ),
    );
  }
}