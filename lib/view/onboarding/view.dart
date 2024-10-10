import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/unit/app_strings.dart';
import 'package:tasky/core/unit/routes.dart';
import 'package:tasky/core/widget/app_image.dart';

import '../../core/unit/app_assets.dart';
import '../../core/widget/app_button.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

SizedBox(
  height: 656.h,
  width: double.infinity,
  child: Stack(
    children: [
      PositionedDirectional(
        height: 482.h,
        width: 408.w,
        start: -15,
        child: Image.asset(
          height: 482.h,
          width: 408.w,
          DataAssets.imagesIntro,
          fit: BoxFit.fill,
        ),
      ),
      PositionedDirectional(
        top: 462.h,
        start: 60.w,
        child: SizedBox(
          width: 256.w,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: DataString.titleOfOnboarding,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff24252C),
              ),
              children: [
                TextSpan(
                  text: DataString.subTitleOfOnboarding,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff6E6A7C),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  )
),
            SizedBox(
              height: 32.h,
            ),
            AppButton(
              onPressed: () {

                GoRouter.of(context).go(AppRouter.rLogIn);
              },
              text: DataString.start,
              icon: SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: const AppImage(
                    path: DataAssets.arrow,
                    fit: BoxFit.scaleDown,
                  )),
            ),
            SizedBox(
              height: 32.h,
            ),
          ],
        ));
  }
}
