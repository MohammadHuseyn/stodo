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

  late String educationCenterDescription;
  late String educationCenter;
  late String name;
  late String description;
  late User creator;

  String get getId => _id;

  List<User> get getJoinRequests => _joinRequests;

  void addJoinRequest(User user) {
    _joinRequests.add(user);
  }

  TaskList(
      {required this.name,
      required this.educationCenter,
      required this.educationCenterDescription,
      required this.creator,
      required this.description}) {
    users.add(creator);
  }
}
