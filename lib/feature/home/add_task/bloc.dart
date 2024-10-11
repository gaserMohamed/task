import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
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
     TaskUploadImageState? uploadState;

    if (!event.taskModel.image.startsWith('http')) {
      uploadImageBloc.add(TaskUploadImageEvent(event.image));
      uploadState  = await uploadImageBloc.stream.firstWhere(
            (state) => state is TaskUploadImageSuccessState || state is TaskUploadImageFailedState,
      );
    }



    if (uploadState is TaskUploadImageSuccessState||event.taskModel.image.startsWith('http')) {
       String? imageUrl;
if(
uploadState is TaskUploadImageSuccessState
) {
   imageUrl =  uploadState.image;
}else{
  imageUrl = event.taskModel.image;
}
      final response = event.isEdit
          ? await DioHelper().updateData(
        endPoint: 'todos/${event.taskModel.sId}',
        data: {
          "image": imageUrl,
          "title": event.taskModel.title,
          "desc": event.taskModel.desc,
          "priority": event.taskModel.priority.toLowerCase(),
          "dueDate": event.taskModel.updatedAt,
        },
        haveToken: true,
      )
          : await DioHelper().sendData(
        endPoint: 'todos',
        data: {
          "image": imageUrl,
          "title": event.taskModel.title,
          "desc": event.taskModel.desc,
          "priority": event.taskModel.priority.toLowerCase(),
          "dueDate": event.taskModel.updatedAt,
        },
        haveToken: true,
      );

      if (response.isSuccess) {
        emit(TaskAddedSuccessState());
      } else {
        emit(TaskAddedFailedState(message: response.message));
      }
    } else if (uploadState is TaskUploadImageFailedState) {
      emit(TaskAddedFailedState(message: 'Image upload failed: ${uploadState.message}'));
    }
  }
}
