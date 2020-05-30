import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final bool isActive;

  const IndicatorWidget({Key key, this.isActive}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: isActive ? Colors.teal : Colors.grey.shade200,
      ),
    );
  }
}
