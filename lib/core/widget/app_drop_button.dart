import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/helper_methods.dart';
import '../unit/app_strings.dart';

class AppDropButton extends StatelessWidget {
  final Color color, fontColor;
  final bool isState,isPriority;
  final String? text;
  final void Function(String?)? onChange;

  AppDropButton({
    super.key,
    this.color = Colors.white,
    required this.fontColor,
    this.onChange,
    this.isState = false,
    this.isPriority = false,
    this.text,
  });

  String? levelOfExperience;
  String? taskState;

  final List<String> levelOfExperiences = [
    DataString.fresh,
    DataString.junior,
    DataString.midLevel,
    DataString.senior,
  ];

  final List<TaskType> taskStates = [
    TaskType.finished,
    TaskType.waiting,
    TaskType.inpogress,
  ];
    final List<TaskPriority> taskPriority = [
      TaskPriority.low,
      TaskPriority.high,
      TaskPriority.medium,
  ];


  @override
  Widget build(BuildContext context) {
    final List<String> items = isState
        ? taskStates.map((e) => e.toString().split('.').last.toUpperCase()).toList()
        : isPriority
        ? taskPriority.map((e) => e.toString().split('.').last.toUpperCase()).toList()
        : levelOfExperiences.map((e) => e.toUpperCase()).toList();

    final String? dropdownValue = (text != null && items.contains(text?.toUpperCase()))
        ? text?.toUpperCase()
        : items.isNotEmpty ? items.first : null;
    print('Dropdown Value: $dropdownValue, Text: $text, Items: $items');

    return DropdownButton<String>(
      isExpanded: true,
      borderRadius: BorderRadius.circular(8.r),
      padding: EdgeInsets.zero,
      elevation: 0,
      dropdownColor: color,
      underline: Container(),
      onChanged: onChange,
      value: dropdownValue,
      icon: SizedBox(
        width: 1.sw - 60.w,
        child: Row(
          children: [
            Text(
              text ?? DataString.levelOfExperience,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: fontColor,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: fontColor,
              size: 24.w,
            ),
          ],
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              item,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: fontColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
