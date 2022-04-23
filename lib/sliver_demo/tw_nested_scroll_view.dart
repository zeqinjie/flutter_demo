import 'package:flutter/material.dart';

/// create by: zhengzeqin
/// create time: 2022/4/19 10:57 上午
/// des: https://h5.48.cn/resource/jsonp/allmembers.php?gid=10
///

class TWNestedScrollView extends StatefulWidget {
  const TWNestedScrollView({Key? key}) : super(key: key);

  @override
  State<TWNestedScrollView> createState() => _TWNestedScrollViewState();
}

class _TWNestedScrollViewState extends State<TWNestedScrollView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _newsKey = const PageStorageKey('news');
  final _technologyKey = const PageStorageKey('technology');
  final List<String> _newsList = List.generate(100, (index) => "news");
  final List<String> _technologyList =
      List.generate(100, (index) => "technology");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return _buildNestedScrollView();
  }

  _buildNestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: Text("zhengzeqin"),
            expandedHeight: 230.0,
            pinned: true,
            flexibleSpace: Container(
              color: Colors.red,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: _tabController,
                tabs: const [
                  Tab(text: '资讯'),
                  Tab(text: '技术'),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildTabNewsList(_newsKey, _newsList),
          _buildTabNewsList(_technologyKey, _technologyList),
        ],
      ),
    );
  }

  _buildTabNewsList(Key key, List<String> list) {
    return ListView.separated(
      key: key,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("${list[index]} =====> $index"),
          subtitle: Text('作者 $index：zhengzeqin}'),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 8,
        );
      },
      itemCount: list.length,
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
