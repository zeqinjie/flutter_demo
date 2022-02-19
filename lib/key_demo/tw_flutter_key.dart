import 'package:flutter/material.dart';

/// create by:  zhengzeqin
/// create time:  2021-12-19 14:29 
/// des:  https://www.bilibili.com/video/BV15k4y1B74z?spm_id_from=333.999.0.0

class TWFlutterKey extends StatelessWidget {
  const TWFlutterKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'key Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("key demo"),),
        body: Column(
          children: const [
            _Box(
              color: Colors.red,
            ),
            _Box(
              color: Colors.grey,
            ),
            _Box(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

}

class _Box extends StatefulWidget {
  final Color color;
  const _Box({Key? key, this.color = Colors.yellow}) : super(key: key);

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<_Box> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _incrementCounter();
      },
      child: Container(
        color: widget.color,
        child: Text("count:$_counter"),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}



