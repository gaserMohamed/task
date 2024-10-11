import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import 'model.dart';

part 'states.dart';
part 'events.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileState> {

  ProfileBloc() : super(ProfileState()) {
    on<ProfileEvent>(_getProfile);
  }

  Future<void> _getProfile(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    print("_getProfile");
    emit(ProfileLoadingState());




    final response = await DioHelper()
        .getData(endPoint: 'auth/profile',haveToken: true);
    final  model =  UserModel.fromJson(response.response!.data);
    print(response.response!.data);

      if (response.isSuccess) {
        emit(ProfileSuccessState(model));
      } else {
        emit(ProfileFailedState(message: response.message));
      }
    }
  }
