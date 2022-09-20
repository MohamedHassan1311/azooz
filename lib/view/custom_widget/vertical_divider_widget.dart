import '../../common/style/colors.dart';
import 'package:flutter/material.dart';

class VerticalDividerCutsWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const VerticalDividerCutsWidget({
    Key? key,
    this.height = 0,
    this.width = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        size: const Size(1, double.infinity),
        painter: DashedLineVerticalPainter(),
      ),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class VerticalDividerWidget extends StatelessWidget {
  final double? height;
  final double? widget;
  final double? horizontal;

  const VerticalDividerWidget({
    Key? key,
    this.height = 20,
    this.widget = 0.7,
    this.horizontal = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal!),
      child: Container(
        color: Palette.kBlack,
        height: height,
        width: widget,
      ),
    );
  }
}
