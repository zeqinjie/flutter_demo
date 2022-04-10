import 'package:flutter/material.dart';

/// create by:  zhengzeqin
/// create time:  2022-04-07 22:06
/// des: 布局探索
/// https://flutter.cn/docs/development/ui/layout/constraints
/// https://www.bilibili.com/video/BV1254y1s7Zo?spm_id_from=333.999.0.0

class TWLayoutApp extends StatelessWidget {
  const TWLayoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    // return _buildLogo1();

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("布局探索"),
        ),
        body: _buildStack(),
      ),
    );
  }

  /// 流程案例
  /// ● 首先，上层 widget 向下层 widget 传递约束条件；
  /// ● 然后，下层 widget 向上层 widget 传递大小信息。
  /// ● 最后，上层 widget 决定下层 widget 的位置。
  Widget _buildLogo1() {
    return Container(
      color: Colors.red,
      width: 0.04,
      height: 0.0008,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: const FlutterLogo(
            size: 11,
          ),
        ),
      ),
    );
  }

  /// 如果想打破这紧约束，可以给 FlutterLogo 添加 Center 父 widget
  Widget _buildLogo2() {
    return Container(
      color: Colors.red,
      width: 0.04,
      height: 0.0008,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: const Center(
            child: FlutterLogo(
              size: 11,
            ),
          ),
        ),
      ),
    );
  }

  /// LayoutBuilder
  /// 打印信息： flutter: BoxConstraints(0.0<=w<=200.0, 0.0<=h<=200.0)
  Widget _buildLogo3() {
    return Container(
      color: Colors.red,
      width: 0.04,
      height: 0.0008,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                print(constraints);
                return const FlutterLogo(
                  size: 11,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Column当crossAxisAlignment为CrossAxisAlignment.stretch
  /// 时候组件会在纵轴调整为紧约束，宽度占满父 widget
  Widget _buildLogo4() {
    return Center(
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: null, child: Text("xxx")),
            ElevatedButton(onPressed: null, child: Text("xxx")),
            LayoutBuilder(
              builder: (context, constraints) {
                print(constraints);
                return FlutterLogo(
                  size: 100,
                );
              },
            ),
            ListView(),
            FlutterLogo(
              size: 200,
            ),
            FlutterLogo(
              size: 50,
            ),
          ],
        ),
      ),
    );
  }

  /// Stack 布局大小
  Widget _buildStack() {
    return Container(
      color: Colors.blue,
      constraints: BoxConstraints(
        minWidth: 20,
        maxWidth: 300,
        minHeight: 20,
        maxHeight: 500,
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        fit: StackFit.passthrough,
        children: [
          // Positioned(
          //   right: -10,
          //   child: Container(
          //     color: Colors.yellow,
          //     child: Text(
          //       "zhengzeqin",
          //       style: TextStyle(fontSize: 20),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.green,
              child: Text(
                "0",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(50, 0),
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
