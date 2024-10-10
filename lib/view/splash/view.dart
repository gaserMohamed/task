import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/logic/cashed_helper.dart';
import '../../core/unit/app_assets.dart';
import '../../core/unit/routes.dart';
import '../../core/widget/app_image.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
             Center(
               child: AppImage(
                height: 36.h,
                width: 100.w,
                path: DataAssets.imagesLogoTask,
                fit: BoxFit.fill,
                           ),
             ),
            PositionedDirectional(
              start: .5.sw+50.w,
              top: .5.sh-8.h,

              child: FadeInRight(
                duration: const Duration(milliseconds: 500),
                child: Swing(
                  delay: const Duration(milliseconds: 200),
                  child: AppImage(
                    path: DataAssets.imagesLogoY,
                    width: 25.w,
                    height: 35.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(milliseconds: 3500),
      () {
        GoRouter.of(context).go(            CachedHelper.isAuth() ?  AppRouter.rOnBoarding :  AppRouter.rHome);

      },
    );
  }
}
