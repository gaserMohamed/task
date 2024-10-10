import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isLoading;
  final FontWeight fontWeight;
  final double fontSize;
  final double width;
  final double height;
  final Widget? icon;

  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
    this.fontWeight = FontWeight.w700,
    this.fontSize = 16,
    this.width = double.infinity,
    this.height = 50,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: GestureDetector(
            onTap: onPressed,

            child: Container(

              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
          alignment: Alignment.center,
              height: height.h,
                width: width.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: fontWeight,
                        fontSize:ScreenUtil().setSp(fontSize),
                      ),
                    ),
                  SizedBox(width:  icon==null ?0: 8.w),
                  icon ?? const SizedBox(),
                ],
              ),
            ),
          ),
        );
  }
}
