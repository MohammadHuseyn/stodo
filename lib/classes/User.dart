import 'dart:math' show Random;

class User {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(1000).toString();
  String firstname = "Unknown";
  String lastname = "Unknown";
  String username = "Unknown";
  late String _password;
  String bio = "Empty";
  late DateTime dateJoined;
  List<User> _friends = [];

  String get getId => _id;

  String get getPass => _password;

  List<User> get getFriends => _friends;

  bool setPass(String newPass, String confirm) {
    if (newPass == confirm) {
      _password = newPass;
      return true;
    }
    return false;
  }

  void addFriend(User friend) {
    _friends.add(friend);
  }
}
