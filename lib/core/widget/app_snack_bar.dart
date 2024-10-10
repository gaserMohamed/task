import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarApp {
  String text;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final BuildContext context;
  String text2 = '';

  SnackBarApp(
      this.context, {
        Key? key,
        this.text = "Verify that the data is correct",
        this.icon = Icons.error_outline,
        this.color = const Color(0xffE92727),
        required this.text2,
        this.backgroundColor = const Color(0xffFDEEEE),
      }) {
    _();
  }

  SnackBarApp.required(
      this.context, {
        required this.text2,
        this.text = "Please enter all required",
        this.icon = Icons.error_outlined,
        this.color = const Color(0xffF88F2D),
        this.backgroundColor = const Color(0xffFFF6EE),
      }) {
    text = "Please enter required $text2";
    _();
  }

  SnackBarApp.success(
      this.context, {
        this.text = "Account successfully created",
        this.icon = Icons.check_circle_outline,
        this.color = const Color(0xff10B981),
        this.backgroundColor = const Color(0xffECF9F5),
      }) {
    _();
  }

  _() {
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 18.r,
                    color: color,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(
                Radius.circular(4),
              ),
            ),
            showCloseIcon: true,
            closeIconColor: color,
            // padding: EdgeInsets.all(16.r),
            clipBehavior: Clip.antiAlias,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h)),
      );
    }
  }
}
