/*
 * @Author: zhengzeqin
 * @Date: 2022-07-20 14:41:08
 * @LastEditTime: 2022-07-20 16:42:07
 * @Description: your project
 */
import 'package:flutter/material.dart';

import 'utils/dates.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    Key? key,
    required this.month,
    this.monthNames,
  }) : super(key: key);

  final int month;
  final List<String>? monthNames;

  @override
  Widget build(BuildContext context) {
    return Text(
      getMonthName(month, monthNames: monthNames),
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
