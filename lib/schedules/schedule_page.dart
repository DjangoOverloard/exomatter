import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/schedules/schedule_widget.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  List<DocumentSnapshot> schedules = [];
  var moreAvailable = true;
  var fetching = false;
  bool ready = false;
  ScrollController scr = new ScrollController();
  TabController tabs;
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
          .limit(10)
          .getDocuments()
          .then((qs) {
        if (qs.documents.length != 0) {
          schedules.addAll(qs.documents);
        }
        tabs = TabController(length: schedules.length, vsync: this);
        moreAvailable = qs.documents.length == 5;
      });
      fetching = false;
      if (!ready) {
        ready = true;
        setState(() {});
      }
    } else {
      ready = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getSchedules();
    super.initState();
  }

  @override
  void dispose() {
    tabs.dispose();
    super.dispose();
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

    return TabBarView(
      controller: tabs,
      children: [
        ...schedules.map(
          (v) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: ScheduleWidget(
              update: () {
                if (mounted) {
                  setState(() {});
                }
              },
              doc: v,
              schedules: schedules,
            ),
          ),
        )
      ],
    );
  }
}
