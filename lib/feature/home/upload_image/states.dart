part of 'bloc.dart';

class TaskUploadImageState {}

class TaskUploadImageLoadingState extends TaskUploadImageState {}

class TaskUploadImageSuccessState extends TaskUploadImageState {
final  String image;
TaskUploadImageSuccessState({required this.image});
}

class TaskUploadImageFailedState extends TaskUploadImageState {
  final String message;

  TaskUploadImageFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
