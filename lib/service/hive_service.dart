import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_stake/model/user_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static initHive() async {
    final applicationDocumentDir = await getApplicationDocumentsDirectory();
    Hive..init(applicationDocumentDir.path)..registerAdapter(UserAdapter());
    await Hive.openBox<User>('user');
  }
  
  static void addZeroUser(){
    final User user = User(username: 'Player name', money: 1000, maxmoney: 1000, sound: false, dailyspin: DateTime(2000));
    Hive.box<User>('user').add(user);
  }

  static User? getUser(){
    final hivebox = Hive.box<User>('user');
    if (hivebox.values.isNotEmpty){
      final result = hivebox.values.first;
      return result;
    }
    else {
      return null;
    }
  }

  static void updateUserMoney(int newMonye){
    final hivebox = Hive.box<User>('user');
    hivebox.putAt(0, User(username: hivebox.values.first.username,
        money: newMonye,
        maxmoney: hivebox.values.first.maxmoney < newMonye ? newMonye : hivebox.values.first.maxmoney,
        sound: hivebox.values.first.sound,
        dailyspin: hivebox.values.first.dailyspin));
  }

  static ValueListenable<Box<User>> getUserListenable() {
    return Hive.box<User>('user').listenable();
  }

  static void updateDateTime(DateTime newDateTime){
    final hivebox = Hive.box<User>('user');
    hivebox.putAt(0, User(username: hivebox.values.first.username,
        money: hivebox.values.first.money,
        maxmoney: hivebox.values.first.maxmoney,
        sound: hivebox.values.first.sound,
        dailyspin: newDateTime));
  }

  static void updateSound(){
    final hivebox = Hive.box<User>('user');
    hivebox.putAt(0, User(username: hivebox.values.first.username,
        money: hivebox.values.first.money,
        maxmoney: hivebox.values.first.maxmoney,
        sound: !hivebox.values.first.sound,
        dailyspin: hivebox.values.first.dailyspin));
  }

  static void changeName(String name){
    final hivebox = Hive.box<User>('user');
    hivebox.putAt(0, User(username: name,
        money: hivebox.values.first.money,
        maxmoney: hivebox.values.first.maxmoney,
        sound: hivebox.values.first.sound,
        dailyspin: hivebox.values.first.dailyspin));
  }
}