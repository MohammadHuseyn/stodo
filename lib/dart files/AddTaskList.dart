import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stodo/classes/TaskList.dart';
import 'package:stodo/dart%20files/HomePage.dart';
import 'package:stodo/main.dart';

import '../classes/User.dart';

class AddTaskList extends StatefulWidget {

  AddTaskList({required this.mainUser});
  User mainUser;
  @override
  State<AddTaskList> createState() => _AddTaskListState();
}

class _AddTaskListState extends State<AddTaskList> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var universityController = TextEditingController();
  var ADController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new TaskList"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: 'Enter a name for your TaskList',
                hintStyle: TextStyle(),
                labelStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'Name',
                prefixIcon: Icon(
                  Icons.list,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
            child: TextField(
              controller: descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: '\nEnter a bio for your TaskList',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'Description',
                prefixIcon: Icon(
                  Icons.short_text,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
            child: TextField(
              controller: ADController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: 'Which major are you studying?',
                hintStyle: TextStyle(),
                labelStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'AD',
                prefixIcon: Icon(
                  Icons.question_mark,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
            child: TextField(
              controller: universityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: 'Which University are you studying in?',
                hintStyle: TextStyle(),
                labelStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'University',
                prefixIcon: Icon(
                  Icons.place,
                ),
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20)
                ),
                child: Text("Create TaskList",style: TextStyle(fontSize: 20),),
                onPressed: (){
                  TaskList list = new TaskList(name: nameController.text, AD: ADController.text, university: universityController.text, creator: widget.mainUser, description: descriptionController.text);
                  setStateNewTaskList(list);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Stodo", mainUser: widget.mainUser)));
                },
              ),
            )
          )
        ],
      ),
    );
  }
  void setStateNewTaskList(TaskList list){
    setState((){
      widget.mainUser.taskLists.add(list);
    });
  }
}
