import 'package:flutter/material.dart';
import 'package:stodo/classes/Task.dart';
import 'package:stodo/classes/TaskList.dart';
import 'package:stodo/classes/User.dart';

import 'dart files/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User mainUser = new User(firstname: "Mohammad Huseyn", lastname: "Amini", username: "mohammadhuseyn");
    mainUser.setPass("password", "password");
    Task task1 = new Task(title: "Task1", description: "desc1", owner: mainUser);
    Task task2 = new Task(title: "Task2", description: "desc2", owner: mainUser);
    Task task3 = new Task(title: "Task3", description: "desc3", owner: mainUser);
    TaskList taskList1 = new TaskList(name: "Task List 1", AD: "CE", university: "Shahid Beheshti University",description: "description of taskList", creator: mainUser);
    taskList1.tasks.add(task1);
    taskList1.tasks.add(task2);
    taskList1.tasks.add(task3);
    Task task4 = new Task(title: "Task4", description: "desc4", owner: mainUser);
    Task task5 = new Task(title: "Task5", description: "desc5", owner: mainUser);
    Task task6 = new Task(title: "Task6", description: "desc6", owner: mainUser);
    TaskList taskList2 = new TaskList(name: "Task List 2", AD: "CE", university: "Shahid Beheshti University",description: "description of taskList", creator: mainUser);
    taskList2.tasks.add(task4);
    taskList2.tasks.add(task5);
    taskList2.tasks.add(task6);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'stodo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stodo',mainUser: mainUser,taskLists: [taskList1,taskList2]),
    );
  }
}
