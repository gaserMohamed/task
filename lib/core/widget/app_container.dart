import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/unit/app_assets.dart';
import 'package:tasky/core/widget/app_image.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    this.withIcon = false,
    required this.text,
  });

  final bool withIcon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 15.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color:const Color.fromRGBO(240, 236, 255, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                withIcon
                    ? Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: AppImage(
                    path: DataAssets.flag,
                    color: Theme.of(context).primaryColor,
                    fit: BoxFit.scaleDown,
                    height: 22.h,
                  ),
                )
                    : const SizedBox.shrink(),
                Text(
                   text,
                  style:TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,)
                ),
              ],
            ),
          ),
          AppImage(
            path:DataAssets.arrowDown,
            fit: BoxFit.scaleDown,
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
