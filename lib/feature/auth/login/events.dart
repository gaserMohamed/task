part of 'bloc.dart';

class LoginEvents {}

class LoginEvent extends LoginEvents {
  late final Map<String, dynamic>? data;
  late final String phone, password;
  LoginEvent({
    required this.phone,
    required this.password,
  }) {
    data = {
      "phone" : phone,
      "password" : password,
    };
    print(data);
  }
}
