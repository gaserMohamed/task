part of 'bloc.dart';

class TaskDeletedEvents {}

class TaskDeletedEvent extends TaskDeletedEvents {
  String id;
  TaskDeletedEvent(
    this.id,
      );
}
