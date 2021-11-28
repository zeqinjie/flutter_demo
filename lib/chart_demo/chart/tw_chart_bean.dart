import 'package:flutter/material.dart';
class TWChartBean {
  String x;
  double y;
  int millisSeconds;
  Color color;

  TWChartBean(
      {required this.x, required this.y, this.millisSeconds = 0, this.color = Colors.black});
}
