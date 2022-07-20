/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-20 16:42:41
 * @Description: your project
 */
import 'package:flutter/material.dart';

class WeekdayRow extends StatelessWidget {
  const WeekdayRow({Key? key}) : super(key: key);

  Widget _weekdayContainer(String weekDay) => Expanded(
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
            child: Text(
              weekDay,
            ),
          ),
        ),
      );

  List<Widget> _renderWeekDays() {
    List<Widget> list = [];
    list.add(_weekdayContainer("周日"));
    list.add(_weekdayContainer("周一"));
    list.add(_weekdayContainer("周二"));
    list.add(_weekdayContainer("周三"));
    list.add(_weekdayContainer("周四"));
    list.add(_weekdayContainer("周五"));
    list.add(_weekdayContainer("周六"));
    return list;
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _renderWeekDays(),
      );
}
