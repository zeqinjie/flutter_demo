import 'dart:math';
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
  late AnimationController _controller;
  late List _list; //存放随机数
  List<TWShowFlake>? _snowFlakes;
  @override
  void initState() {
    super.initState();
    _initShowFlake();
    // _initShape();
  }

  void _initShowFlake() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat();
  }

  void _initShape() {
    var rng = Random();
    _list = [
      rng.nextDouble(),
      rng.nextDouble(),
      rng.nextDouble(),
      rng.nextDouble(),
      rng.nextDouble(),
    ];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.addStatusListener((status) {
      //动画结束后反转
      if (status == AnimationStatus.completed) {
        _controller.reverse();
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
        setState(() {});
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _snowFlakes ??= List.generate(100, (index) => TWShowFlake(context));
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    // return _buildMusicContent();
    return _buildSnowmanContent(context);
  }

  Widget _buildSnowmanContent(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final snowFlakes = _snowFlakes ?? [];
            snowFlakes.forEach((element) {
              element.fall();
            });
            return CustomPaint(
              painter: TWSnowmanPainter(context: context, snowFlakes: snowFlakes),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMusicContent() {
    return Center(
      child: CustomPaint(
        size: Size(sizeWidth, sizeWidth),
        painter: TWMusicPainter(_controller, _list),
      ),
    );
  }
}

class TWSnowmanPainter extends CustomPainter {
  List<TWShowFlake> snowFlakes;
  BuildContext context;

  TWSnowmanPainter({required this.context, required this.snowFlakes});

  @override
  void paint(Canvas canvas, Size size) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final p = Paint()..color = Colors.white;
    // TODO: implement paint
    canvas.drawCircle(
      size.center(const Offset(0, 100)),
      60,
      p,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(width / 2.0, height - 180),
        width: 200,
        height: 250,
      ),
      p,
    );
    snowFlakes.forEach((element) {
      canvas.drawCircle(Offset(element.x, element.y), element.radius, p);
    });
    //
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class TWShowFlake {
  BuildContext context;
  late double x;
  late double y;
  late double radius;
  late double velocity;


  TWShowFlake(this.context) {
    _initData();
  }

  _initData() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    x = Random().nextDouble() * width;
    y = Random().nextDouble() * height;
    radius = Random().nextDouble() * 2 + 2;
    velocity = Random().nextDouble() * 4 + 2;
  }

  fall() {
    y = y + velocity;
    if (y > 800) {
      _initData();
    }
  }
}

class TWMusicPainter extends CustomPainter {
  final Animation<double> spread;
  final List _list;

  TWMusicPainter(this.spread, this._list) : super(repaint: spread);

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
  bool shouldRepaint(covariant TWMusicPainter oldDelegate) {
    return oldDelegate.spread != spread;
  }
}
