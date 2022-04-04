import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-31 22:02
/// des: 其他动画 https://www.bilibili.com/video/BV1dz411v76Z?spm_id_from=333.999.0.0

class TWAnimationView extends StatefulWidget {
  const TWAnimationView({Key? key}) : super(key: key);

  @override
  State<TWAnimationView> createState() => _TWAnimationViewState();
}

class _TWAnimationViewState extends State<TWAnimationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _height = 50.0;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    timeDilation = 5;
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // // ticker 使用
    // Ticker ticker = Ticker(
    //   (_) => setState(
    //     () {
    //       _height += 1;
    //       if (_height > 500) {
    //         _height = 100;
    //       }
    //     },
    //   ),
    // );
    //
    // ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Text(
              "其他动画",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        // _buildAnimatedContainer(),
        // _buildAnimatedBuilder(),
        _buildHeroAnimated(),
        Positioned(
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () {
                setState(
                  () {
                    _height += 50;
                    if (_height > 500) {
                      _height = 100;
                    }
                    if (_isLoading) {
                      _controller.stop(); // reset: 重置恢复   stop: 暂停
                    } else {
                      _controller.repeat(
                          reverse: true); // forward: 执行一次  repeat: 重复执行
                    }
                    _isLoading = !_isLoading;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 隐式动画原理 , AnimatedContainer 继承 ImplicitlyAnimatedWidget 本质就是 ImplicitlyAnimatedWidgetState
  /// ImplicitlyAnimatedWidgetState 使用的是 AnimationController
  Widget _buildAnimatedContainer() {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: Colors.blue,
        height: _height,
        width: _height,
      ),
    );
  }

  /// 显示动画原理, AnimatedBuilder 继承 AnimatedWidget 本质就是 _AnimatedState
  /// _AnimatedState 使用的是 void _handleChange() { setState(() { });}
  Widget _buildAnimatedBuilder() {
    final Animation heightAnimation =
        Tween(begin: 100.0, end: 200.0).animate(_controller);
    return AnimatedBuilder(
      animation: _controller,
      child: const Text(
        "AnimatedBuilder",
        textAlign: TextAlign.center,
      ),
      // 这个 child 及传给 builder 的，从性能考虑
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 200,
            height: heightAnimation.value,
            child: child,
          ),
        );
      },
    );
  }

  /// hero 动画
  Widget _buildHeroAnimated() {
    const path = "assets/beauty.jpeg";
    return Center(
      child: GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: List.generate(100, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return TWHeroAnimation(
                    tag: index.toString(),
                    assetImageName: path,
                  );
                }),
              );
            },
            child: Hero(
              tag: index.toString(),
              child: Image.asset(path),
            ),
          );
        }),
      ),
    );
  }
}

/// hero 动画
class TWHeroAnimation extends StatelessWidget {
  final String tag;
  final String assetImageName;

  const TWHeroAnimation({
    Key? key,
    required this.tag,
    required this.assetImageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero 基础动画详情'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: tag,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  assetImageName,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Material(
                child: Text(
                  "介绍了几篇 Hero 动画，我们来一个 Hero 动画应用案例。在一些应用中，列表的元素和详情的内容是一致的，这个时候利用 Hero 动画切换到详情会感觉无缝过渡，用户体验会更好",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
