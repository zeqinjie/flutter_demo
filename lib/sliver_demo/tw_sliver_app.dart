import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// create by:  zhengzeqin
/// create time:  2022-03-26 11:05
/// des: https://www.bilibili.com/video/BV1RK4y1R74t/?spm_id_from=pageDriver
///

class TWSliverApp extends StatefulWidget {
  const TWSliverApp({Key? key}) : super(key: key);

  @override
  State<TWSliverApp> createState() => _TWSliverAppState();
}

class _TWSliverAppState extends State<TWSliverApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("FLutter Demo Home Page"),
            ),
            SliverPadding(
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
                Icon(Icons.nat),
                Icon(Icons.start),
                Icon(Icons.repeat),
                Icon(Icons.radar),
              ]),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
              ),
            ),
            SliverFillRemaining(
              // 占剩余空间
              child: Placeholder(),
            ),
            SliverLayoutBuilder(
              builder: (BuildContext context, SliverConstraints constraints) {
                print(constraints);
                return SliverToBoxAdapter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
