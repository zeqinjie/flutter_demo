import 'package:flutter/material.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-19 23:40
/// des: 隐式动画

class TWAnimationImplicitView extends StatefulWidget {
  const TWAnimationImplicitView({Key? key}) : super(key: key);

  @override
  State<TWAnimationImplicitView> createState() =>
      _TWAnimationImplicitViewState();
}

class _TWAnimationImplicitViewState extends State<TWAnimationImplicitView> {
  double _height = 100;
  double _opacity = 0;
  bool _isEnd = false;
  double _counterBegin = 0;
  double _counterEnd = 10;
  double _count = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Text(
              "隐式动画",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        _buildAnimatedContainer(),
        // _buildCurvesAnimated(),
        // _buildTweenAnimated(),
        // _buildAnimatedCounter(),
        // _buildTWAnimatedCounter(),
        Positioned(
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _height += 50;
                  if (_height > 500) {
                    _height = 100;
                  }
                  _opacity += 0.2;
                  if (_opacity > 1) {
                    _opacity = 0;
                  }
                  _isEnd = !_isEnd;

                  final _counterTemp = _counterBegin;
                  _counterBegin = _counterEnd;
                  _counterEnd = _counterTemp;
                  _count++;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 1、只有 AnimatedContainer 下的属性参与到动画变化中， child的 widget 的属性变化则无效
  /// 2、AnimatedSwitcher 组件用来执行动画组件的切换功能，如 A 的缩小 B 的放大，当 child 组件的 key 或者类型改变会引起动画
  /// 3、AnimatedSwitcher child 如果等于 null 会隐私消失， 默认 FadeTransition 渐变动画
  Widget _buildAnimatedContainer() {
    return Center(
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 1000),
        height: _height,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(spreadRadius: 25, blurRadius: 25)],
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.blue, Colors.white],
            stops: [0.2, 0.3],
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: _height >= 500
              ? null
              : Center(
                  key: ValueKey(_height),
                  child: Text(
                    "zhengzeqin $_height",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  /// 更多动画及曲线
  /// 隐式动画都有个 curve 曲线 Curves.bounceOut, // 弹性结束
  /// 官方文档：https://api.flutter-io.cn/flutter/animation/Curves-class.html
  Widget _buildCurvesAnimated() {
    return Center(
      child: AnimatedPadding(
        curve: Curves.bounceOut, // 弹性结束
        duration: const Duration(milliseconds: 1000),
        padding: EdgeInsets.only(top: _height),
        child: AnimatedOpacity(
          curve: Curves.bounceInOut, // 弹性开始和结束
          duration: const Duration(milliseconds: 2000),
          opacity: _opacity,
          child: Container(
            height: 300,
            width: 300,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  /// between 之间 ，关键帧动画
  Widget _buildTweenAnimated() {
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double value, Widget? child) {
          return Opacity(
            opacity: value,
            child: Container(
              alignment: Alignment.center,
              height: 300,
              width: 300,
              color: Colors.blue,
              child: Transform.rotate(
                angle: value * 6.28, // 6.28 一圈 p 是 3.14 半圈
                child: Text(
                  "zhengzeqin",
                  style: TextStyle(fontSize: 10 + 10 * value),
                ),
              ),
            ),
          );
        },
        tween: Tween<double>(begin: 0.0, end: _isEnd ? 0.0 : 1.0),
      ),
    );
  }

  /// 滚动的计算器
  Widget _buildAnimatedCounter() {
    const fontSize = 200.0;
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 200,
        height: fontSize,
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 1),
          tween: Tween(begin: _counterBegin, end: _counterEnd),
          builder: (BuildContext context, double value, Widget? child) {
            final whole = value ~/ 1; // 取整数
            final decimal = value - whole; // 取小数
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -fontSize * decimal, // 0 -> -100
                  child: Opacity(
                    opacity: 1.0 - decimal, // 1.0 -> 0.0
                    child: Text(
                      "$whole",
                      style: const TextStyle(
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: fontSize - decimal * fontSize, // 100 -> 0
                  child: Opacity(
                    opacity: decimal, // 0 -> 1.0
                    child: Text(
                      "${whole + 1}",
                      style: const TextStyle(
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 滚动的计算器
  Widget _buildTWAnimatedCounter() {
    const fontSize = 100.0;
    return Center(
      child: Container(
        color: Colors.blue,
        width: 200,
        height: 120,
        child: TWAnimatedCounter(
          fontSize: fontSize,
          count: _count,
        ),
      ),
    );
  }
}

/// 封装计数器
class TWAnimatedCounter extends StatelessWidget {
  final Duration? duration;
  final double fontSize;
  final double count;

  const TWAnimatedCounter({
    Key? key,
    this.duration,
    this.fontSize = 100,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration ?? const Duration(seconds: 1),
      tween: Tween(end: count),
      builder: (BuildContext context, double value, Widget? child) {
        final whole = value ~/ 1; // 取整数
        final decimal = value - whole; // 取小数
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -fontSize * decimal, // 0 -> -100
              child: Opacity(
                opacity: 1.0 - decimal, // 1.0 -> 0.0
                child: Text(
                  "$whole",
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            Positioned(
              top: fontSize - decimal * fontSize, // 100 -> 0
              child: Opacity(
                opacity: decimal, // 0 -> 1.0
                child: Text(
                  "${whole + 1}",
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
