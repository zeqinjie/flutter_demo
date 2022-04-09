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
    return _buildLogo3();
  }

  /// 流程案例
  /// ● 首先，上层 widget 向下层 widget 传递约束条件；
  /// ● 然后，下层 widget 向上层 widget 传递大小信息。
  /// ● 最后，上层 widget 决定下层 widget 的位置。
  Widget _buildLogo1(){
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
  Widget _buildLogo2(){
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
  Widget _buildLogo3(){
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
}
