import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// create by: zhengzeqin
/// create time: 2022/4/19 11:09 上午
/// des: 

class TWCustomScrollView extends StatelessWidget {
  const TWCustomScrollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCustomScrollView();
  }

  Widget _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text("FLutter Demo Home Page"),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverOpacity(  // SliverFadeTranition, SliverIgnorePointer
            opacity: 0.5,
            sliver: SliverToBoxAdapter(
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ),
        ),
        SliverGrid(
          delegate: SliverChildListDelegate([
            const Icon(Icons.nat),
            const Icon(Icons.start),
            const Icon(Icons.repeat),
            const Icon(Icons.radar),
          ]),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
          ),
        ),
        const SliverFillRemaining(
          // 占剩余空间
          child: Placeholder(),
        ),
        SliverLayoutBuilder(
          builder: (BuildContext context, SliverConstraints constraints) {
            print(constraints);
            return const SliverToBoxAdapter();
          },
        ),
      ],
    );
  }

}
