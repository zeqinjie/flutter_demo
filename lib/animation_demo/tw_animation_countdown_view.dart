///
/// [Author] COPY FORM Alex (https://dartpad.cn/8c01732ac676f282463ae59e8b170e1d?null_safety=true)
///
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class TWAnimationCountdownView extends StatefulWidget {
  const TWAnimationCountdownView({Key? key}) : super(key: key);

  @override
  _TWAnimationCountdownViewState createState() =>
      _TWAnimationCountdownViewState();
}

class _TWAnimationCountdownViewState extends State<TWAnimationCountdownView> {
  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Container buildContent() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          TWCountdownButton(
            duration: Duration(seconds: 30),
            width: 120,
            height: 40,
            radius: 10000,
            borderWidth: 5,
            borderColor: Colors.grey,
            color: Colors.blue,
          ),
          SizedBox(height: 30),
          TWCountdownButton(
            duration: Duration(seconds: 20),
            width: 80,
            height: 80,
            radius: 40,
            borderWidth: 4,
            borderColor: Colors.green,
            color: Colors.deepOrangeAccent,
          ),
          SizedBox(height: 30),
          TWCountdownButton(
            duration: Duration(seconds: 10),
            width: 80,
            height: 40,
            borderWidth: 3,
            borderColor: Colors.purple,
            color: Colors.lightGreenAccent,
          ),
        ],
      ),
    );
  }
}

class TWCountdownButton extends StatefulWidget {
  const TWCountdownButton({
    Key? key,
    required this.duration,
    this.width,
    this.height,
    this.radius = 0,
    this.borderWidth = 2,
    this.borderColor,
    this.color,
    this.builder,
    this.onStart,
    this.onCancel,
    this.onEnd,
  }) : super(key: key);

  final Duration duration;
  final double? width;
  final double? height;
  final double radius;
  final double borderWidth;
  final Color? borderColor;
  final Color? color;
  final Widget Function(
    BuildContext context,
    bool isStarted,
    bool hasEnded,
  )? builder;
  final VoidCallback? onStart;
  final VoidCallback? onCancel;
  final VoidCallback? onEnd;

  @override
  _TWCountdownButtonState createState() => _TWCountdownButtonState();
}

class _TWCountdownButtonState extends State<TWCountdownButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..addStatusListener(_listener);

  final ValueNotifier<bool> _isStarted = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hasEnded = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_listener)
      ..dispose();
    super.dispose();
  }

  void _listener(AnimationStatus status) {
    final bool isAnimating =
        status == AnimationStatus.forward || status == AnimationStatus.reverse;
    if (isAnimating && !_isStarted.value) {
      _isStarted.value = true;
      _hasEnded.value = false;
    } else if (!isAnimating && !_hasEnded.value) {
      _isStarted.value = false;
      _hasEnded.value = true;
      widget.onEnd?.call();
    }
  }

  void _onTap() {
    if (_controller.isAnimating) {
      widget.onCancel?.call();
      _controller
        ..stop()
        ..reset();
      _isStarted.value = false;
      _hasEnded.value = false;
    } else {
      widget.onStart?.call();
      _controller
        ..reset()
        ..forward();
    }
  }

  Widget _defaultChildBuilder(
    BuildContext context,
    bool isStarted,
    bool hasEnded,
  ) {
    return Center(
      child: Text(
        isStarted
            ? 'Cancel'
            : hasEnded
                ? 'Done'
                : 'Send',
        style: TextStyle(
          color: isStarted
              ? Theme.of(context).primaryColor
              : hasEnded
                  ? Theme.of(context).textTheme.caption?.color
                  : Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = CustomPaint(
      painter: TWCountdownButtonPainter(
        controller: _controller,
        radius: widget.radius,
        borderColor: widget.borderColor ?? Colors.grey,
        borderWidth: widget.borderWidth,
        color: widget.color ?? Theme.of(context).primaryColor,
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: _isStarted,
        builder: (_, bool isStarted, __) => ValueListenableBuilder<bool>(
          valueListenable: _hasEnded,
          builder: (_, bool hasEnded, __) =>
              widget.builder?.call(context, isStarted, hasEnded) ??
              _defaultChildBuilder(context, isStarted, hasEnded),
        ),
      ),
      size: Size(widget.width ?? 0, widget.height ?? 0),
    );
    if (widget.width != null || widget.height != null) {
      child = ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: widget.width ?? double.infinity,
          maxHeight: widget.height ?? double.infinity,
        ),
        child: child,
      );
    }
    child = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: child,
    );
    return child;
  }
}

class TWCountdownButtonPainter extends CustomPainter {
  TWCountdownButtonPainter({
    required this.controller,
    required this.borderColor,
    required this.borderWidth,
    required this.color,
    this.radius = 0,
  }) : super(repaint: controller);

  final AnimationController controller;
  final Color borderColor;
  final double borderWidth;
  final Color color;
  final double radius;

  late double effectiveRadius;

  Radius get _circularRadius => Radius.circular(effectiveRadius);

  /// 按需创建内容，并不是每次绘制的时候都需要新的实例。
  Path? _path;
  PathMetric? _metric;

  @override
  void paint(Canvas canvas, Size size) {
    // 圆角值需要在一个合理的范围内，超出二分之一宽或高时，以最小值为准。
    effectiveRadius = math.min(
      radius,
      math.min(size.width / 2, size.height / 2),
    );

    final Paint _paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    _path ??= _createPath(size);
    _metric ??= _path!.computeMetrics().single;

    canvas.drawPath(_path!, _paint);

    // 进度为 0 的时候，直接将 RRect 全部填充，不进行其他操作。
    if (controller.value == 0) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          _circularRadius,
        ),
        Paint()
          ..style = PaintingStyle.fill
          ..color = color,
      );
      return;
    }

    _drawMetric(canvas, _paint, _metric!);
  }

  @override
  bool shouldRepaint(TWCountdownButtonPainter oldDelegate) {
    final bool _shouldRepaint = borderWidth != oldDelegate.borderWidth ||
        borderColor != oldDelegate.borderColor ||
        color != oldDelegate.color ||
        radius != oldDelegate.radius ||
        controller != oldDelegate.controller;
    // 需要重绘的时候，置空实例进行重建。
    if (_shouldRepaint) {
      _path = null;
      _metric = null;
    }
    return _shouldRepaint;
  }

  Path _createPath(Size size) {
    final double _width = size.width;
    final double _height = size.height;

    return Path()
      // 移动到二分之一宽度位置，作为起始点。
      ..moveTo(_width / 2, 0)
      // 右上直线
      ..relativeLineTo(_width / 2 - effectiveRadius, 0)
      // 右上弧
      ..relativeArcToPoint(
        Offset(effectiveRadius, effectiveRadius),
        radius: _circularRadius,
      )
      // 右侧直线
      ..relativeLineTo(0, _height - effectiveRadius * 2)
      // 右下弧
      ..relativeArcToPoint(
        Offset(-effectiveRadius, effectiveRadius),
        radius: _circularRadius,
      )
      // 底部直线
      ..relativeLineTo(-_width + effectiveRadius * 2, 0)
      // 左下弧
      ..relativeArcToPoint(
        Offset(-effectiveRadius, -effectiveRadius),
        radius: _circularRadius,
      )
      // 左侧直线
      ..relativeLineTo(0, -_height + effectiveRadius * 2)
      // 左上弧
      ..relativeArcToPoint(
        Offset(effectiveRadius, -effectiveRadius),
        radius: _circularRadius,
      )
      // 左上直线
      ..relativeLineTo(_width / 2 - effectiveRadius, 0)
      ..close();
  }

  void _drawMetric(Canvas canvas, Paint paint, PathMetric metric) {
    canvas.drawPath(
      metric.extractPath(0, metric.length * controller.value),
      paint..color = borderColor,
    );
  }
}
