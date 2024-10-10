import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/unit/app_themes.dart';
import 'core/unit/routes.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,

        builder: (context, child) => MediaQuery(
          
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child:
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: MaterialApp.router(
              title: 'Tasky',
          routerConfig: AppRouter.router,

          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          ),
        ),
        ),
        );
  }
}
