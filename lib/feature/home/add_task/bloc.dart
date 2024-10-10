import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/feature/home/tasks/model.dart';
import 'package:tasky/feature/home/upload_image/bloc.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';
part 'events.dart';

class TasksAddedBloc extends Bloc<TaskAddedEvents, TaskAddedState> {
  final UploadImageBloc uploadImageBloc;

  TasksAddedBloc({required this.uploadImageBloc}) : super(TaskAddedState()) {
    on<TaskAddedEvent>(_addedTasks);
  }

  Future<void> _addedTasks(
      TaskAddedEvent event, Emitter<TaskAddedState> emit) async {
    emit(TaskAddedLoadingState());

    uploadImageBloc.add(TaskUploadImageEvent(event.image));

    await for (final uploadState in uploadImageBloc.stream) {
      if (uploadState is TaskUploadImageSuccessState) {
        final imageUrl = uploadState.image;

        final response =event.isEdit? await DioHelper().updateData(
          endPoint: 'todos/${event.taskModel.sId}',
          data: {  "image"  : imageUrl,
            "title" : event.taskModel.title,
            "desc" : event.taskModel.desc,
            "priority" :event.taskModel.priority,//low , medium , high
            "status" :event.taskModel.status,//low , medium , high
            "dueDate" : event.taskModel.status},
          haveToken: true,
        ): await DioHelper().sendData(
          endPoint: 'todos',
          data: {  "image"  : imageUrl,
            "title" : event.taskModel.title,
            "desc" : event.taskModel.desc,
            "priority" :event.taskModel.priority.toLowerCase(),//low , medium , high
            "dueDate" : event.taskModel.updatedAt},
          haveToken: true,
        );
emit(TaskAddedLoadingState());
        if (response.isSuccess) {
          emit(TaskAddedSuccessState());
        } else {
          emit(TaskAddedFailedState(message: response.message));
        }

        break;
      } else if (uploadState is TaskUploadImageFailedState) {
        emit(TaskAddedFailedState(message: 'Image upload failed: ${uploadState.message}'));
        break;
      }
    }
  }
}
