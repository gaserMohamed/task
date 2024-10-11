part of 'bloc.dart';

class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
 final UserModel userModel;
 ProfileSuccessState(this.userModel);
}

class ProfileFailedState extends ProfileState {
  final String message;

  ProfileFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
