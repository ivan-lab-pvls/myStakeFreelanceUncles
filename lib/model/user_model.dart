import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  final String username;
  @HiveField(1)
  final int money;
  @HiveField(2)
  final int maxmoney;
  @HiveField(3)
  final bool sound;
  @HiveField(4)
  final DateTime dailyspin;

  User({
   required this.username,
   required this.money,
   required this.maxmoney,
   required this.sound,
   required this.dailyspin
});
}