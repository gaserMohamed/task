import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/feature/home/tasks/model.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class TasksOneTaskBloc extends Bloc<TaskOneTaskEvents, TaskOneTaskState> {
  TasksOneTaskBloc() : super(TaskOneTaskState()) {
    on<TaskOneTaskEvent>(_deleteTasks);
  }

  Future<void> _deleteTasks(
      TaskOneTaskEvent event, Emitter<TaskOneTaskState> emit) async {
    emit(TaskOneTaskLoadingState());


    final response = await DioHelper()
        .getData(endPoint: 'todos/${event.id}',haveToken: true);

    if (response.isSuccess) {
      final TaskModel task =  TaskModel.fromJson(response.response!.data);
      print(response.response!.data);
      emit(TaskOneTaskSuccessState(
        taskModel: task
      ));
    } else {
      emit(TaskOneTaskFailedState(
        message: response.message,
      ));
    }
  }

}
