import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String fullName;
  @HiveField(1)
  String password;
  UserModel({required this.fullName,required this.password});
}
