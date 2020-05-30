import 'package:flutter/material.dart';

class ExContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets padding;

  const ExContainer({
    Key key,
    this.child,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(6.0);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 8.0),
            blurRadius: 12.0,
            color: Colors.black.withOpacity(0.125),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(12.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
