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
  var educationCenterController = TextEditingController();
  var educationCenterDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              controller: educationCenterController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText:
                    'Which University, institute, Company, etc is this for?',
                hintStyle: TextStyle(),
                labelStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'University | Company | etc',
                prefixIcon: Icon(
                  Icons.place,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
            child: TextField(
              controller: educationCenterDescriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: 'Add some description if you like about last field ',
                hintStyle: TextStyle(),
                labelStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'EC, C description',
                prefixIcon: Icon(
                  Icons.question_mark,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                  child: Text(
                    "Create TaskList",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if (nameController.text == "" ||
                        descriptionController.text == "" ||
                        educationCenterController.text == "") {
                      String toast = "";
                      if (nameController.text == "") {
                        toast = "\"Name\"";
                      }
                      if (descriptionController.text == "") {
                        toast += toast == "" ? "" : ", ";
                        toast += "\"Description\"";
                      }
                      if (educationCenterController.text == "") {
                        toast += toast == "" ? "" : ", ";
                        toast += "\"University\\Company\"";
                      }
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(toast + " Can not be empty"),
                      ));
                    } else {
                      TaskList list = new TaskList(
                          name: nameController.text,
                          educationCenter: educationCenterController.text,
                          educationCenterDescription:
                              educationCenterController.text,
                          creator: widget.mainUser,
                          description: descriptionController.text);
                      setStateNewTaskList(list);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                  title: "Stodo", mainUser: widget.mainUser)));
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }

  void setStateNewTaskList(TaskList list) {
    setState(() {
      widget.mainUser.taskLists.add(list);
    });
  }
}
