import 'dart:math' show Random;
import 'User.dart';
import 'Task.dart';

class TaskList {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(1000).toString();
  List<Task> tasks = [];
  List<User> users = [];
  List<User> _joinRequests = [];
  String university = "";
  String AD = "";
  String name = "";
  late User creator;
  late DateTime dateCreated;

  String get getId => _id;
  List<User> get getJoinRequests => _joinRequests;

  void addJoinRequest(User user) {
    _joinRequests.add(user);
  }
}