import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/unit/app_strings.dart';
import 'package:tasky/feature/home/tasks/model.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class TasksBloc extends Bloc<TasksEvents, TasksStates> {
  TasksBloc() : super(TasksStates()) {
    on<GetTasksEvent>(_getTasks);
  }

  Future<void> _getTasks(
      GetTasksEvent event, Emitter<TasksStates> emit) async {
    if(event.allTask==null)
    {
      emit(TasksLoadingState());
    }

    final response = await DioHelper()
        .getData(endPoint: 'todos?page=${event.page}',haveToken: true);

    if (response.isSuccess && response.response?.data != null) {
      final listTasks = List<TaskModel>.from(
          response.response!.data.map((e) => TaskModel.fromJson(e)) ?? []
      );
      print("Parsed listTasks: ${listTasks.isEmpty}");

      emit(TasksSuccessState(
        model: [...event.allTask ?? [], ...listTasks],
        type: event.type,
        isAllLoaded: listTasks.isEmpty||listTasks.length<9,
      ));
print("listTasks.isEmpty&&listTasks.length<9,${listTasks.isEmpty||listTasks.length<9}");

  } else {
      emit(TasksFailedState(
        message: response.message,
      ));
    }
  }


}
