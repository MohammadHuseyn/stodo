import 'dart:math' show Random;
import 'User.dart';
import 'Task.dart';

class TaskList {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(1000).toString();

  List<Task> tasks = [];
  List<User> users = [];
  List<User> _joinRequests = [];
  final DateTime dateCreated = DateTime.now();

  late String AD;
  late String university;
  late String name;
  late User creator;

  String get getId => _id;

  List<User> get getJoinRequests => _joinRequests;

  void addJoinRequest(User user) {
    _joinRequests.add(user);
  }

  TaskList(
      {required this.name,
      required this.AD,
      required this.university,
      required this.creator}) {}
}
