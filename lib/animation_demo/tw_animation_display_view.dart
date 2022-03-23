import 'package:flutter/material.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-20 21:05
/// des: 显式动画

class TWAnimationDisplayView extends StatefulWidget {
  const TWAnimationDisplayView({Key? key}) : super(key: key);

  @override
  State<TWAnimationDisplayView> createState() => _TWAnimationDisplayViewState();
}

/// Ticker 是每次刷新时候。 60hz 每秒触发 60 次
class _TWAnimationDisplayViewState extends State<TWAnimationDisplayView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // lowerBound -> upperBound 默认是 0 -> 1。
    _controller = AnimationController(
      // upperBound: 10,
      // lowerBound: 1,
      vsync: this, // 垂直同步
      duration: const Duration(milliseconds: 1000),
    );
    _controller.addListener(() {
      print("${_controller.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Text(
              "显式动画",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        // Column(
        //   children: [
        //     _buildRotationTransition(),
        //     _buildFadeTransition(),
        //     _buildScaleTransition(),
        //     _buildTweenAnimation(),
        //   ],
        // ),
        // Align(child: _buildSlidingBoxAnimation()),
        Align(child: _buildCustomAnimation()),
        Positioned(
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  if (_isLoading) {
                    _controller.stop(); // reset: 重置恢复   stop: 暂停
                  } else {
                    _controller.repeat(reverse: true); // forward: 执行一次  repeat: 重复执行
                  }
                  _isLoading = !_isLoading;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 旋转动画
  Widget _buildRotationTransition() {
    return Center(
      child: RotationTransition(
        turns: _controller,
        child: const Icon(
          Icons.refresh,
          size: 100,
        ),
      ),
    );
  }

  /// 透明度渐变动画
  Widget _buildFadeTransition() {
    return Center(
      child: FadeTransition(
        opacity: _controller, // 透明度
        child: Container(
          height: 100,
          width: 100,
          color: Colors.blue,
        ),
      ),
    );
  }

  /// 缩放动画
  Widget _buildScaleTransition() {
    return Center(
      child: ScaleTransition(
        scale: _controller, // 缩放倍数
        child: Container(
          height: 100,
          width: 100,
          color: Colors.yellow,
        ),
      ),
    );
  }

  /// tween 关键帧动画
  /// 通过 _controller.drive(Tween(...)) 添加 Tween 关键帧开始与结束值。
  /// 等价的写法 Tween(...).animate(_controller)
  /// chain 叠加一个 tween Interval(0.8, 1.0) 即表示 从时间 80% 之前的时间动画不执行，剩余 20% 时间完成动画
  /// 在 Slide 平移动画中，offset 是以 （0，0）原点。偏移 0.5 即是 0.5 倍数
  Widget _buildTweenAnimation() {
    return SlideTransition(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.red,
      ),
      position: Tween(
        begin: const Offset(0, 0),
        end: const Offset(0.5, 1),
      )
          .chain(
            CurveTween(
              curve: const Interval(0.8, 1.0), // Curves.bounceOut
            ),
          )
          .animate(_controller),
      // position: _controller.drive(
      //   Tween(
      //     begin: const Offset(0, 0),
      //     end: const Offset(0.5, 1),
      //   ),
      // ),
    );
  }


  /// 交错动画展示
  Widget _buildSlidingBoxAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TWSlidingBox(controller: _controller, color: Colors.blue.withOpacity(0.1), interval: const Interval(0.0, 0.2)),
        TWSlidingBox(controller: _controller, color: Colors.blue.withOpacity(0.3), interval: const Interval(0.2, 0.4)),
        TWSlidingBox(controller: _controller, color: Colors.blue.withOpacity(0.5), interval: const Interval(0.4, 0.6)),
        TWSlidingBox(controller: _controller, color: Colors.blue.withOpacity(0.7), interval: const Interval(0.6, 0.8)),
        TWSlidingBox(controller: _controller, color: Colors.blue.withOpacity(0.9), interval: const Interval(0.8, 1.0)),
        TWSlidingBox(controller: _controller, color: Colors.blue, interval: const Interval(0.8, 1.0)),
      ],
    );
  }

  /// 自定义动画
  Widget _buildCustomAnimation() {
    final Animation opacityAnimation = Tween(begin: 0.5, end: 0.8).animate(_controller);
    final Animation heightAnimation = Tween(begin: 100.0, end: 200.0).animate(_controller);
    return AnimatedBuilder(
      animation: _controller,
      child: const Text("Custom Animation",textAlign: TextAlign.center,), // 这个 child 及传给 builder 的，从性能考虑
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 100,
            height: heightAnimation.value,
            child: child,
          ),
        );
      },
    );
  }

}

/// 交错动画
class TWSlidingBox extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;

  const TWSlidingBox({
    Key? key,
    required this.controller,
    required this.color,
    required this.interval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 100,
        color: color,
      ),
      position: Tween(
        begin: Offset.zero,
        end: const Offset(0.1, 0),
      )
          .chain(
            CurveTween(curve: interval),
          )
          .chain(
            CurveTween(curve: Curves.bounceInOut),   // g(f(x))
          )
          .animate(controller),
    );
  }
}
