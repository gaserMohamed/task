import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/logic/helper_methods.dart';
import 'package:tasky/feature/auth/register/bloc.dart';
import 'package:tasky/feature/home/get_one_task/bloc.dart';
import 'package:tasky/view/add_task/view.dart';
import 'package:tasky/view/home/view.dart';
import 'package:tasky/view/onboarding/view.dart';
import 'package:tasky/view/splash/view.dart';

import '../../feature/auth/login/bloc.dart';
import '../../feature/home/tasks/bloc.dart';
import '../../feature/home/tasks/model.dart';
import '../../view/auth/login/view.dart';
import '../../view/auth/sing_up/sing_up.dart';
import '../../view/task_details/barcode/view.dart';
import '../../view/task_details/view.dart';
import '../logic/get_it.dart';

abstract class AppRouter {
  static const String rOnBoarding = '/on_boarding';
  static const String rLogIn = '/log_in';
  static const String rSignUp = '/sing_up';
  static const String rHome = '/home';
  static const String rBarcode = '/barcode';
  static const String rAdd = '/add_task';
  static const String rTaskDetails = r'/task-details';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
        const SplashView()      ),
      GoRoute(
        path: rAdd,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;

          final bool fromEdit = args?['fromEdit'] ?? false;
          final TaskModel? taskModel = args?['taskModel'];
          return AddTaskBody(
            fromEdit: fromEdit,
            taskModel: taskModel,
          );
        },
      ),

      GoRoute(
        path: rTaskDetails,
        builder: (context, state) {
          final TaskModel task = state.extra! as TaskModel;
          return DetailsView(taskModel: task);
        },
      )
      ,GoRoute(
        path: rOnBoarding,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: rLogIn,
        builder: (context, state) => BlocProvider(
            create: (BuildContext context) {
              return getIt<LoginBloc>();
            },
            child: const LoginView()),
      ),
      GoRoute(
        path: rSignUp,
        builder: (context, state) => BlocProvider(
            create: (BuildContext context) {
              return getIt<RegisterBloc>();
            },
            child: const SingUpView()),
      ),
      GoRoute(
        path: rBarcode,
          builder: (context, state) => BlocProvider(
              create: (BuildContext context) {
                return getIt<TasksOneTaskBloc>();
              },
              child: const QrScanView()),

      ),      GoRoute(
        path: rHome,
        builder: (context, state) => BlocProvider(
            create: (BuildContext context) {
              return getIt<TasksBloc>();
            },
            child: const HomePageView()),
      ),
    ],
  );
}
