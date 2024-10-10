import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class TasksDeletedBloc extends Bloc<TaskDeletedEvents, TaskDeletedState> {
  TasksDeletedBloc() : super(TaskDeletedState()) {
    on<TaskDeletedEvent>(_deleteTasks);
  }

  Future<void> _deleteTasks(
      TaskDeletedEvent event, Emitter<TaskDeletedState> emit) async {
    emit(TaskDeletedLoadingState());

//5354544545
    final response = await DioHelper()
        .deleteData(endPoint: 'todos/${event.id}',haveToken: true);

    if (response.isSuccess) {
      print(response.response!.data);
      emit(TaskDeletedSuccessState());
    } else {
      emit(TaskDeletedFailedState(
        message: response.message,
      ));
    }
  }

}
