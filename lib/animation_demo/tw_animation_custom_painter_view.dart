import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//paint区域大小
double sizeWidth = 20;

class TWAnimationCustomPainterView extends StatefulWidget {
  const TWAnimationCustomPainterView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TWAnimationCustomPainterViewState();
  }
}

class _TWAnimationCustomPainterViewState
    extends State<TWAnimationCustomPainterView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List _list; //存放随机数
  @override
  void initState() {
    super.initState();
    var rng = Random();
    _list = [
      rng.nextDouble(),
      rng.nextDouble(),
      rng.nextDouble(),
      rng.nextDouble(),
      rng.nextDouble(),
    ];
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.addStatusListener((status) {
      //动画结束后反转
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      //反转后重置随机值，继续播放
      if (status == AnimationStatus.dismissed) {
        var rng = Random();
        _list = [
          rng.nextDouble(),
          rng.nextDouble(),
          rng.nextDouble(),
          rng.nextDouble(),
          rng.nextDouble(),
        ];
        print(_list);
        setState(() {});
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CustomPaint(
        size: Size(sizeWidth, sizeWidth),
        painter: ShapePainter(controller, _list),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final Animation<double> spread;
  final List _list;

  ShapePainter(this.spread, this._list) : super(repaint: spread);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3;
    var shader = const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            tileMode: TileMode.clamp,
            colors: [Colors.red, Colors.amber])
        .createShader(const Rect.fromLTRB(0, 0, 30, 30));
    paint.shader = shader;

    //平移到左下角
    canvas.translate(0, size.height);

    //画5根线
    canvas.drawLine(const Offset(0, 0),
        Offset(0, -sizeWidth * (spread.value) * _list[0]), paint);
    canvas.drawLine(
        const Offset(5, 0),
        Offset(5, -sizeWidth * (spread.value) * _list[1] * _list[3] - 4),
        paint);
    canvas.drawLine(const Offset(10, 0),
        Offset(10, -sizeWidth * (spread.value) * _list[2] - 1), paint);
    canvas.drawLine(
        const Offset(15, 0),
        Offset(15, -sizeWidth * (spread.value) * _list[3] * _list[1] - 2),
        paint);
    canvas.drawLine(const Offset(20, 0),
        Offset(20, -sizeWidth * (spread.value) * _list[4] - 3), paint);
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.spread != spread;
  }
}
