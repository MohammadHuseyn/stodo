import 'dart:ffi';
import 'dart:math' show Random;

import 'package:stodo/classes/TaskList.dart';
import 'package:stodo/classes/Users.dart';

class User {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(1000).toString();

  final DateTime dateJoined = DateTime.now();
  List<User> _friends = [];
  List<TaskList> taskLists = [];
  String firstname;
  String lastname;
  late String username;

  late String _password;
  String bio = "";
  double taskPoint = 0;

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

  void removeFriend({User? friend, int? index}) {
    if (friend == null)
      _friends.removeAt(index!);
    else
      _friends.remove(friend);
  }

  void setBio(String bio) {
    this.bio = bio;
  }

  User({
    required this.firstname,
    required this.lastname,
    required this.username,
  }) {
    Users.users[_id] = this;
    // print("users length: " + Users.users.length.toString() + " " + this.username + " " + usernames.contains(username).toString());
  }
}
