import 'package:flutter/material.dart';
import 'package:stodo/classes/Task.dart';
import 'package:stodo/classes/TaskList.dart';
import 'classes/User.dart';
import 'classes/Users.dart';
import 'dart files/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User mainUser = User(
      firstname: "Mohammad Huseyn",
      lastname: "Amini",
      username: "mohammadhuseyn",
    );
    mainUser.setPass("password", "password");

    User mostafa = User(
        firstname: "Mostafa", lastname: "Mostafavi", username: "mostafa.m");
    User morteza = User(
        firstname: "Morteza", lastname: "Mortazavi", username: "morteza.m");
    User ali = User(firstname: "ali", lastname: "alavi", username: "ali.a");
    mostafa.setPass("password", "password");
    morteza.setPass("password", "password");
    ali.setPass("password", "password");

    mainUser.addFriend(mostafa);
    mainUser.addFriend(morteza);
    mostafa.addFriend(mainUser);
    morteza.addFriend(mainUser);

    mainUser.friendRequest.add(ali);
    Task task1 = Task(
        title: "Task1",
        description: "desc1\nthis is a new task for \nnothing. its just a task",
        ownerId: mainUser.getId);
    Task task2 =
        Task(title: "Task2", description: "desc2", ownerId: mainUser.getId);
    Task task3 =
        Task(title: "Task3", description: "desc3", ownerId: mainUser.getId);
    TaskList taskList1 = TaskList(
        name: "Task List 1",
        educationCenterDescription: "Computer Engineering",
        educationCenter: "Shahid Beheshti University",
        description: "description of taskList",
        creatorId: mainUser.getId);
    taskList1.addJoinRequest(ali);
    taskList1.tasks.add(task1);
    taskList1.tasks.add(task2);
    taskList1.tasks.add(task3);
    Task task4 =
        Task(title: "Task4", description: "desc4", ownerId: mainUser.getId);
    Task task5 =
        Task(title: "Task5", description: "desc5", ownerId: mainUser.getId);
    Task task6 =
        Task(title: "Task6", description: "desc6", ownerId: mainUser.getId);
    TaskList taskList2 = TaskList(
        name: "Task List 2",
        educationCenterDescription: "CE",
        educationCenter: "Shahid Beheshti University",
        description: "description of taskList",
        creatorId: mainUser.getId);
    taskList2.tasks.add(task4);
    taskList2.tasks.add(task5);
    taskList2.tasks.add(task6);

    mainUser.taskLists.add(taskList1);
    mainUser.taskLists.add(taskList2);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'stodo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stodo', mainUserId: mainUser.getId),
    );
  }
}
