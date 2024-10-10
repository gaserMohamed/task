import 'package:get_it/get_it.dart';
import 'package:tasky/feature/home/get_one_task/bloc.dart';
import 'package:tasky/feature/home/tasks/bloc.dart';


import '../../feature/auth/login/bloc.dart';
import '../../feature/auth/register/bloc.dart';

var getIt = GetIt.instance;
void getItServices() {

  //Auth
  getIt.registerFactory<RegisterBloc>(() => RegisterBloc());
  getIt.registerFactory<LoginBloc>(() => LoginBloc());

  getIt.registerFactory<TasksBloc>(() => TasksBloc());
  getIt.registerFactory<TasksOneTaskBloc>(() => TasksOneTaskBloc());
 }
