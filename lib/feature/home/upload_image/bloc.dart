import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class UploadImageBloc
    extends Bloc<TaskUploadImageEvents, TaskUploadImageState> {
  UploadImageBloc() : super(TaskUploadImageState()) {
    on<TaskUploadImageEvent>(_deleteTasks);
  }

  Future<void> _deleteTasks(
      TaskUploadImageEvent event, Emitter<TaskUploadImageState> emit) async {
    emit(TaskUploadImageLoadingState());
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        event.Image!.path,
        filename: event.Image!.path.split("/").last,
        contentType: MediaType("image", "jpeg"),
      ),
    });

    final response = await DioHelper().sendData(
      endPoint: 'upload/image',
      haveToken: true,
      data: formData,
    );

    if (response.isSuccess) {
      final String image =response.response!.data["image"];
      print(response.response!.data);
      showMessage(
        message: "Image uploaded successfully",
        type:MassageType.success,
      );
      emit(TaskUploadImageSuccessState(image:"https://todo.iraqsapp.com/images/$image"));
    } else {

      emit(TaskUploadImageFailedState(
        message: response.message,
      ));
    }
  }
}
