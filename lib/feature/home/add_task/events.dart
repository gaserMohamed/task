part of 'bloc.dart';

class TaskAddedEvents {}

class TaskAddedEvent extends TaskAddedEvents {
  TaskModel taskModel;
  File? image;
  final bool isEdit;
  TaskAddedEvent(
      this.taskModel,this.image
      ,this.isEdit
      );
}
