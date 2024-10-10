part of 'bloc.dart';

class TaskDeletedState {}

class TaskDeletedLoadingState extends TaskDeletedState {}

class TaskDeletedSuccessState extends TaskDeletedState {}

class TaskDeletedFailedState extends TaskDeletedState {
  final String message;

  TaskDeletedFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
