import 'dart:ui';
import 'package:flutter/material.dart';

class TWChartPieBean {
  double value;
  String type;
  double rate;
  Color color;
  double startAngle;
  double sweepAngle;

  TWChartPieBean(
      {required this.value,
      this.type = "",
      this.rate = 0,
      this.color = Colors.black,
      this.startAngle = 0,
      this.sweepAngle = 0});
}
