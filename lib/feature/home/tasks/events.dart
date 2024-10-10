part of 'bloc.dart';

class TasksEvents {}

class GetTasksEvent extends TasksEvents {
  TaskType type;
  int page;
  List<TaskModel>? allTask;
  GetTasksEvent(
    this.type,
  {this.page=1
  ,
    this.allTask
  }
      );
}
