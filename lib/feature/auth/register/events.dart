part of 'bloc.dart';

class RegisterEvents {}

class RegisterEvent extends RegisterEvents {
  final String phone, displayName, password, address,level;
  final int experienceYears;
  late final Map<String, dynamic>? data;
  RegisterEvent({
    required this.phone,
    required this.displayName,
    required this.password,
    required this.address,
    required this.level,
    required this.experienceYears,
  }) {
    data = {
      "phone" : phone,
      "password" : password,
      "displayName" : displayName,
      "experienceYears" : experienceYears.round(),
      "address" : address,
      "level" : level.toLowerCase()
    };
  }
}
