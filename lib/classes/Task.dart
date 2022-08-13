import 'dart:math' show Random;

import 'User.dart';
import 'Users.dart';

class Task {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(100000).toString();

  bool done = false;
  bool stared = false;

  List<User> tagged = [];
  final DateTime dateCreated = DateTime.now();
  late DateTime deadline;
  late String title;
  late String description;
  late String ownerId;

  String get getId => _id;

  Task({
    required this.title,
    required this.description,
    required this.ownerId,
  }){
    tagged.add(Users.users[ownerId]!);
    DateTime now = DateTime.now();
    deadline = DateTime(now.year,now.month,now.day + 1,now.hour,now.minute,now.second);
  }
}
