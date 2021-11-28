import 'dart:ui';
import 'package:flutter/material.dart';
import '../painter/tw_chart_pie_painter.dart';
import '../tw_chart_pie_bean.dart';

class TWChartPie extends StatefulWidget {
  final Duration duration;
  final Size size;
  final List<TWChartPieBean> chartBeans;
  final Color? backgroundColor; //绘制的背景色
  final bool isAnimation; //是否执行动画
  final double R, centerR; //半径,中心圆半径
  final Color centerColor; //中心圆颜色
  final double fontSize; //刻度文本大小
  final Color fontColor; //文本颜色

  const TWChartPie({
    Key? key,
    required this.size,
    required this.chartBeans,
    this.duration = const Duration(milliseconds: 800),
    this.backgroundColor,
    this.isAnimation = true,
    this.R = 0,
    this.centerR = 0,
    this.centerColor = Colors.blue,
    this.fontSize = 12,
    this.fontColor = Colors.yellow,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TWChartPieState();
}

class TWChartPieState extends State<TWChartPie>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  double _value = 0;
  double begin = 0.0, end = 360;

  @override
  void initState() {
    super.initState();
    if ( widget.isAnimation) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      if(_controller == null) return;
      Tween(begin: begin, end: end).animate(_controller!)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            print('绘制完成');
          }
        })
        ..addListener(() {
          _value = _controller!.value;
          setState(() {});
        });
      _controller!.forward();
    }
  }

  @override
  void dispose() {
    if (_controller != null) _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var painter = TWChartPiePainter(
      widget.chartBeans,
      value: _value,
      R: widget.R,
      centerR: widget.centerR,
      centerColor: widget.centerColor,
      fontSize: widget.fontSize,
      fontColor: widget.fontColor,
    );
    return CustomPaint(
        size: widget.size,
        foregroundPainter: widget.backgroundColor != null ? painter : null,
        child: widget.backgroundColor != null
            ? Container(
                width: widget.size.width,
                height: widget.size.height,
                color: widget.backgroundColor,
              )
            : null,
        painter: widget.backgroundColor == null ? painter : null);
  }
}
