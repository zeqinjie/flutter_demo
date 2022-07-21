/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-21 16:43:24
 * @Description: your project
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tw_chart_demo/calendar_demo/tw_calendar/tw_calendar_list.dart';
import 'package:tw_chart_demo/common/colors/tw_colors.dart';

class TWCalendarView extends StatefulWidget {
  const TWCalendarView({
    Key? key,
  }) : super(key: key);

  @override
  _TWCalendarViewState createState() => _TWCalendarViewState();
}

class _TWCalendarViewState extends State<TWCalendarView> {
  @override
  Widget build(BuildContext context) {
    return TWCalendarList(
      firstDate: DateTime(2022, 7, 21),
      lastDate: DateTime(2022, 9, 21),
      // selectedStartDate: DateTime(2022, 8, 28),
      // selectedEndDate: DateTime(2022, 9, 2),
      headerView: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          '日历组件',
          style: TextStyle(
            color: TWColors.tw333333,
            fontSize: 18.w,
          ),
        ),
      ),
      onSelectFinish: (selectStartTime, selectEndTime) {
        List<DateTime> result = <DateTime>[];
        result.add(selectStartTime);
        if (selectEndTime != null) {
          result.add(selectEndTime);
        }
        Navigator.pop(context, result);
      },
    );
  }
}
