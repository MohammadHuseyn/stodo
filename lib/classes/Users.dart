import 'package:stodo/classes/User.dart';

class Users {
  static Map<String, User> users = {};
  static User? searchByUsername(String usrename){
    for (int i = 0; i < users.keys.length; i++){
      String key = users.keys.elementAt(i);
      if (users[key]!.username == usrename) {
        return users[key];
      }
    }
    return null;
  }
}