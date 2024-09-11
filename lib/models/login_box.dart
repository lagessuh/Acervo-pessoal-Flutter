import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LoginUserHive {
  @HiveField(0)
  String? email;

  @HiveField(1)
  String? password;

  LoginUserHive({required this.email, required this.password});
}
