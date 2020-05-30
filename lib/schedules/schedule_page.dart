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

    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: ScheduleWidget(
                doc: schedules[0],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
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
                        '6 activities',
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_downward,
                  ),
                  color: Colors.black54,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
