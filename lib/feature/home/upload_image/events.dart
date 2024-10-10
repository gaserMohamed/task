part of 'bloc.dart';

class TaskUploadImageEvents {}

class TaskUploadImageEvent extends TaskUploadImageEvents {
final  File? Image;
  TaskUploadImageEvent(
    this.Image,
      );
}
