part of 'bloc.dart';

class TaskAddedState {}

class TaskAddedLoadingState extends TaskAddedState {}

class TaskAddedSuccessState extends TaskAddedState {

}

class TaskAddedFailedState extends TaskAddedState {
  final String message;

  TaskAddedFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
