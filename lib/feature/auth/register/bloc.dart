import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/cashed_helper.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(RegisterStates()) {
    on<RegisterEvent>(_register);
  }

  Future<void> _register(
      RegisterEvent event, Emitter<RegisterStates> emit) async {
    emit(RegisterLoadingState());

//5354544545
    final response = await DioHelper()
        .sendData(endPoint: 'auth/register', data: event.data);

    if (response.isSuccess) {
      CachedHelper.saveData(
          token: response.response!.data['access_token'],
          id: response.response!.data['_id'],
          refreshToken: response.response!.data['refresh_token']);

      emit(RegisterSuccessState(
        message: response.message,
        phone: event.phone,

      ));
    } else {
      emit(RegisterFailedState(
        message: response.message,
      ));
    }
  }
}
