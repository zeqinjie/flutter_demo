import 'package:flutter/material.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-15 22:37
/// des: 动画

class TWAnimationApp extends StatefulWidget {
  const TWAnimationApp({Key? key}) : super(key: key);

  @override
  State<TWAnimationApp> createState() => _TWAnimationAppState();
}

class _TWAnimationAppState extends State<TWAnimationApp> {
  double _height = 100;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '动画 Demo',
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("动画 demo"),
        ),
        body: _buildAnimatedContainer(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              _height += 50;
              if (_height > 500) {
                _height = 100;
              }
            });
          },
        ),
      ),
    );
  }

  /// 隐式动画
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
          child: _height >= 500 ? null : Center(
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

  Widget _buildAnimated() {
    return Center();
  }
}
