import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/schedules/schedule_widget.dart';
import 'package:exom/widgets/container.dart';
import 'package:exom/widgets/indicator.dart';
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
  var curPage = 0;

  getSchedules() async {
    if (!fetching && moreAvailable && schedules.length == 0) {
      fetching = true;
      var query = Firestore.instance
          .collection('Schedules')
          .orderBy('time', descending: true);
      await (schedules.length != 0
              ? query.startAfterDocument(schedules.last)
              : query)
          .limit(2)
          .getDocuments()
          .then((qs) {
        if (qs.documents.length != 0) {
          schedules.addAll(qs.documents);
        }
        moreAvailable = qs.documents.length == 5;
      });
      fetching = false;
      if (!ready) {
        ready = true;
        setState(() {});
      }
    }else{
      ready = true;
      setState((){});
    }
  }

  @override
  void initState() {
    getSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!ready) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.teal),
        ),
      );
    }

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: ScheduleWidget(
        update: (){
          if(mounted){
            setState((){});
          }
        },
        doc: schedules[curPage],
      ),
    );
  }
}
