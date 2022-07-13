import 'dart:math' show Random;

import 'User.dart';

class Task {
  final String _id =
      DateTime.now().millisecond.toString() + Random().nextInt(1000).toString();
  String title = "";
  String description = "";
  late User owner;
  bool done = false;
  List<User> tagged = [];
  late DateTime dateCreated;

  String get getId => _id;
}