part of 'bloc.dart';

class TaskOneTaskState {}

class TaskOneTaskLoadingState extends TaskOneTaskState {}

class TaskOneTaskSuccessState extends TaskOneTaskState {
final  TaskModel taskModel;
TaskOneTaskSuccessState({required this.taskModel});
}

class TaskOneTaskFailedState extends TaskOneTaskState {
  final String message;

  TaskOneTaskFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
