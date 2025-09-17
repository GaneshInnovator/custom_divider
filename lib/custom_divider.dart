import 'package:flutter/material.dart';

class CustomDivider extends StatefulWidget {

  final DividerStyle style;
  final DividerOrientation orientation;
  final Color? color;

  final double? dashWidth;

  final double? thickness;

  final double? padTop;

  final double? padBottom;

  final double? padLeft;

  final double? padRight;

  CustomDivider({
    Key? key,
    this.style = DividerStyle.SOLID,
    this.orientation = DividerOrientation.HORIZONTAL,
    this.color,
    this.dashWidth = 8,
    this.thickness,
    this.padTop = 0,
    this.padBottom = 0,
    this.padLeft = 0,
    this.padRight = 0
  }) : super(key: key);

  @override
  _CustomDividerState createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  _CustomDividerState();

  @override
  Widget build(BuildContext context) {

    if(widget.style == DividerStyle.SOLID) {
      if (widget.orientation == DividerOrientation.HORIZONTAL) {
        return Padding(
          padding: EdgeInsets.only(top: widget.padTop ?? 0, bottom: widget.padBottom ?? 0),
          child: Divider(
            height: 1,
            thickness: widget.thickness ?? 1,
            color: widget.color ?? Colors.grey[300],
          ),
        );
      }
      else {
        return Padding(
          padding: EdgeInsets.only(left: widget.padLeft ?? 0, right: widget.padRight ?? 0),
          child: VerticalDivider(
            width: 1,
            thickness: widget.thickness ?? 1,
            color: widget.color ?? Colors.grey[300],
          ),
        );
      }
    }
    if (widget.orientation == DividerOrientation.HORIZONTAL) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          final boxWidth = constraints.constrainWidth();
          final dashWidth = (widget.style == DividerStyle.DASHED ? widget.dashWidth ?? 8 : 2).floorToDouble();
          final dashCount = (boxWidth / ((widget.style == DividerStyle.DASHED ? 1.5 : 3) * dashWidth)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return Padding(
                padding: EdgeInsets.only(top: widget.padTop ?? 0, bottom: widget.padBottom ?? 0),
                child: SizedBox(
                  width: dashWidth,
                  height: widget.style == DividerStyle.DOTTED ? widget.thickness ?? 2 : widget.thickness ?? 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: widget.color ?? Colors.grey[300]),
                  ),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          );
        },
      );
    }
    else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var boxHeight = constraints.constrainHeight();
          if (boxHeight == double.infinity) {
            boxHeight = 0;
          }
          final dashHeight = (widget.style == DividerStyle.DASHED ? widget.dashWidth ?? 8 : 2).floorToDouble();
          final dashCount = (boxHeight / ((widget.style == DividerStyle.DASHED ? 1.5 : 3) * dashHeight)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return Padding(
                padding: EdgeInsets.only(left: widget.padLeft ?? 0, right: widget.padRight ?? 0),
                child: SizedBox(
                  width: widget.style == DividerStyle.DOTTED ? widget.thickness ?? 2: widget.thickness ??1,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: widget.color ?? Colors.grey[300]),
                  ),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.vertical,
          );
        },
      );
    }

  }
}

enum DividerStyle {
  SOLID, DOTTED, DASHED
}
enum DividerOrientation {
  HORIZONTAL, VERTICAL
}