import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exom/widgets/container.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  final DocumentSnapshot doc;

  const ScheduleWidget({Key key, this.doc}) : super(key: key);
  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

Color _getIndexColor(double p) => Color.lerp(Colors.green, Colors.blue, p);

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                height: 66.0,
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
                        onPressed: () {},
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

class UpcomingSchedule extends StatefulWidget {
  @override
  _UpcomingScheduleState createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}
