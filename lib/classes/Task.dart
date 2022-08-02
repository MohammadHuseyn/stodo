import 'dart:math' show Random;

import 'User.dart';

class Task {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(1000).toString();

  bool done = false;
  List<User> tagged = [];
  final DateTime dateCreated = DateTime.now();
  late DateTime deadline;
  late String title;
  late String description;
  late User owner;

  String get getId => _id;

  Task({
    required this.title,
    required this.description,
    required this.owner,
  }){
    tagged.add(owner);
    DateTime now = DateTime.now();
    deadline = DateTime(now.year,now.month,now.day + 1);
  }
}
