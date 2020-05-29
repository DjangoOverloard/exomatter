import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostWid extends StatefulWidget {
  final doc;

  const PostWid({Key key, this.doc}) : super(key: key);
  @override
  _PostWidState createState() => _PostWidState();
}

class _PostWidState extends State<PostWid> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
            Text(
              'Zhangir Siranov',
              style: textTheme.caption,
            ),
            SizedBox(height: 4.0),
            Text(
              '5 Minute workout',
              style: textTheme.headline6,
            ),
            SizedBox(height: 4.0),
            Text(
              '5 minute workout that lets you ease your mind and brain and stay focused throughout the day while being healthy.',
              style: textTheme.subtitle1,
            ),
            SizedBox(height: 8.0),
            Text(
              'Tags',
              style: textTheme.caption,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                3,
                (index) => Chip(
                  label: Text(
                    index == 0
                        ? "Workout"
                        : index == 1 ? "Exercising" : "Kazakh Culture",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
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
          ],
        ),
      ),
    );
  }
}
