part of 'bloc.dart';

class LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String message;
  LoginSuccessState({required this.message}) {
    showMessage(
      message: message,
      type: MassageType.success,
    );
  }
}

class LoginFailedState extends LoginStates {
  final String msg;
  final MassageType type;

  LoginFailedState({required this.msg, this.type = MassageType.failed}) {
    showMessage(
      message: msg,
      type: type,
    );
  }
}
