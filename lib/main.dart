import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/bloc_observer.dart';
import 'core/logic/cashed_helper.dart';
import 'core/logic/get_it.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  CachedHelper.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,

    DeviceOrientation.portraitDown,
  ]);
  getItServices();
  Bloc.observer = AppBlocObserver();
  runApp(
    const MyApp(),
  );
}
