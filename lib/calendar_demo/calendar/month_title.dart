/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-20 22:56:44
 * @Description: your project
 */
import 'package:flutter/material.dart';

import 'utils/dates.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    Key? key,
    required this.month,
    required this.year,
    this.monthNames,
  }) : super(key: key);

  final int month;
  final int year;
  final List<String>? monthNames;

  @override
  Widget build(BuildContext context) {
    final monthTitle = getMonthName(month, monthNames: monthNames);
    final yearTitle = getYearName(year);
    final title = yearTitle + monthTitle;
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
