import 'package:flutter/material.dart';


class ScheduleWid extends StatefulWidget {
  final doc;

  const ScheduleWid({Key key, this.doc}) : super(key: key);
  @override
  _ScheduleWidState createState() => _ScheduleWidState();
}

class _ScheduleWidState extends State<ScheduleWid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(4), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Schedule for ${retDat(widget.doc.data['time'].toDate())}', style: TextStyle(
              color: Colors.black.withOpacity(0.6), fontSize: 24, fontWeight: FontWeight.bold, 
            )),
            Padding(
              padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: List.generate(widget.doc.data['tagNames'].length, (index){
                        return Padding(
                          padding: EdgeInsets.only(top: index!=0?10:0),
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5), 
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26, 
                                  blurRadius: 2, 
                                ),
                              ],
                            ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                                                                              child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Text(widget.doc.data['activities'][index].toString(), style: TextStyle(
                              color: Colors.black, fontSize: 18, 
                            )),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                                                          child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('${widget.doc.data['tagNames'][index]}, credit: ${widget.doc.data['links'][index==6?5:index]}', style: TextStyle(
                                  color: Colors.teal, fontSize: 14, 
                                )),
                              ),
                            ),
                                                          ],
                                                        ),
                                                      ),
                          ),); 
                      }),
                          ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 36.0,
                  height: 36.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_upward),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 36.0,
                  height: 36.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_downward),
                    onPressed: () {},
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 36.0,
                  height: 36.0,
                  child: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}


retDat(date){
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