import 'package:flutter/material.dart';

class ExContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color indicatorColor;

  ExContainer({
    Key key,
    this.child,
    this.padding,
    this.onTap,
    this.width,
    this.height,
    this.indicatorColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = borderRadius ?? BorderRadius.circular(8.0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 8.0),
            blurRadius: 12.0,
            color: Colors.black.withOpacity(0.125),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: _borderRadius,
            child: Row(
              children: <Widget>[
                if (indicatorColor != null)
                  Container(width: 8.0, color: indicatorColor),
                Expanded(
                  child: Padding(
                    padding: padding ?? const EdgeInsets.all(12.0),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
