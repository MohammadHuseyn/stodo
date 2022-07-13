import 'dart:math' show Random;

class User {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(1000).toString();

  final DateTime dateJoined = DateTime.now();
  List<User> _friends = [];

  late String firstname;
  late String lastname;
  late String username;

  late String _password;
  late String bio;

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

  void setBio(String bio) {
    this.bio = bio;
  }

  User({
    required this.firstname,
    required this.lastname,
    required this.username,
  });
}
