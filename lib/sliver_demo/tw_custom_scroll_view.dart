import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

/// create by: zhengzeqin
/// create time: 2022/4/19 11:09 上午
/// des: https://h5.48.cn/resource/jsonp/allmembers.php?gid=10

class Member {
  String id = '';
  String name = '';
  String team = '';

  Member({required this.id, required this.name, this.team = ''});

  String get pic {
    return 'https://www.snh48.com/images/member/zp_$id.jpg';
  }
}

class TWCustomScrollView extends StatefulWidget {
  const TWCustomScrollView({Key? key}) : super(key: key);

  @override
  State<TWCustomScrollView> createState() => _TWCustomScrollViewState();
}

class _TWCustomScrollViewState extends State<TWCustomScrollView> {
  final List<Member> _member = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMemberCustomScrollView();
  }

  _fetchData() async {
    const url = 'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10';
    final res = await get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw ('error');
    }
    final json = convert.jsonDecode(res.body);
    final members = json['rows'].map<Member>((row) {
      return Member(id: row['sid'], name: row['sname'], team: row['tname']);
    });
    setState(() {
      _member.addAll(members);
    });
  }

  Widget _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text("FLutter Demo Home Page"),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverOpacity(
            // SliverFadeTranition, SliverIgnorePointer
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

  Widget _buildMemberCustomScrollView() {
    return CustomScrollView(
      slivers: [
        // const SliverToBoxAdapter(
        //   child: Center(child: Text('Team SII')),
        // ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _MySliverPersistentHeaderDelegate('SII'),
        ),
        _buildTeamList('SII'),
        SliverPersistentHeader(
          pinned: true,
          delegate: _MySliverPersistentHeaderDelegate('NII'),
        ),
        _buildTeamList('NII'),
        SliverPersistentHeader(
          pinned: true,
          delegate: _MySliverPersistentHeaderDelegate('HII'),
        ),
        _buildTeamList('HII'),
        SliverPersistentHeader(
          pinned: true,
          delegate: _MySliverPersistentHeaderDelegate('X'),
        ),
        _buildTeamList('X'),
      ],
    );
  }

  // SliverList _buildTeamList(String teamName) {
  //   final teamMembers =
  //       _member.where((element) => element.team == teamName).toList();
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (con, index) {
  //         final m = teamMembers[index];
  //         return ListTile(
  //           title: Text(m.name),
  //           subtitle: Text(m.id),
  //           leading: ClipOval(
  //             child: CircleAvatar(
  //               child: Image.network(m.pic),
  //               radius: 32,
  //               backgroundColor: Colors.white,
  //             ),
  //           ),
  //         );
  //       },
  //       childCount: teamMembers.length,
  //     ),
  //   );
  // }

  SliverGrid _buildTeamList(String teamName) {
    final teamMembers =
    _member.where((element) => element.team == teamName).toList();
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      delegate: SliverChildBuilderDelegate(
            (con, index) {
          final m = teamMembers[index];
          return Column(
            children: [
              CircleAvatar(
                child: Image.network(m.pic),
                radius: 32,
                backgroundColor: Colors.white,
              ),
              Text(m.name),
              // Text(m.id),
            ],
          );
        },
        childCount: teamMembers.length,
      ),
    );
  }
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  _MySliverPersistentHeaderDelegate(this.title);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Text('Team $title'),
      color: Colors.pinkAccent,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 32;

  @override
  // TODO: implement minExtent
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant _MySliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return oldDelegate.title != title;
  }
}
