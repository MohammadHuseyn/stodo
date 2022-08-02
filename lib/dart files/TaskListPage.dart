import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../classes/Task.dart';
import '../classes/TaskList.dart';
import '../classes/User.dart';
import 'dart:math';

class TaskListPage extends StatefulWidget {
  TaskListPage({required this.taskList, required this.mainUser});

  TaskList taskList;
  User mainUser;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    var titleC = TextEditingController(), descC = TextEditingController();
    // var focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Center(
                child: Text(
              widget.taskList.name,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
            subtitle: Center(
                child: Text(
              widget.taskList.users.length.toString() +
                  (widget.taskList.users.length <= 1 ? " user" : " users"),
              style: TextStyle(color: Colors.white70, fontSize: 15),
            )),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: widget.taskList.tasks.length,
                itemBuilder: (context, index) {
                  Task task = widget.taskList.tasks.elementAt(index);
                  return Card(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: ListTile(
                      subtitle: Wrap(spacing: 5, children: [
                        Timeago(
                            builder: (context, value) => Text(value + ', '),
                            date: task.dateCreated),
                        Text(task.description),
                      ]),
                      leading: IconButton(
                        icon: Icon(
                          task.done
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            task.done = !task.done;
                          });
                        },
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          task.title,
                          style: TextStyle(
                              decoration: task.done
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                child: Text(
                  "add a new task",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding:
                        EdgeInsets.symmetric(horizontal: 60, vertical: 25)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return bottomSheetWidget(titleC,
                              hint: "Select a title for you task and type it",
                              subject: " Title ",
                              iconButtonAfter: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  if (titleC.text != "") {
                                    late Task newTask;
                                    setState(() {
                                      newTask = new Task(
                                          title: titleC.text,
                                          description: '',
                                          owner: widget.mainUser);
                                    });
                                    Navigator.pop(context);

                                    showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                        ),
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return bottomSheetWidget(descC,
                                                hint:
                                                    "Make a description for you task",
                                                subject: " Description ",
                                                iconButtonAfter: IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    size: 25,
                                                    color: Colors.teal,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      newTask.description =
                                                          descC.text;
                                                      int taskListIndex = widget
                                                          .mainUser.taskLists
                                                          .indexOf(
                                                              widget.taskList);
                                                      widget.mainUser.taskLists
                                                          .elementAt(
                                                              taskListIndex)
                                                          .tasks
                                                          .add(newTask);
                                                    });
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => TaskListPage(
                                                                taskList: widget
                                                                    .taskList,
                                                                mainUser: widget
                                                                    .mainUser)));
                                                  },
                                                ),
                                                iconButtonBefore: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 25,
                                                      color: Colors.red,
                                                    )));
                                          });
                                        });
                                  }
                                },
                              ),
                              iconButtonBefore: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Transform.rotate(
                                      angle: -0.5 * pi,
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 25,
                                        color: Colors.red,
                                      ))));
                        });
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  Widget bottomSheetWidget(TextEditingController controller,
      {required IconButton iconButtonAfter,
      required IconButton iconButtonBefore,
      required String subject,
      required String hint}) {
    return Container(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Row(
          children: [
            iconButtonBefore,
            Expanded(
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration.collapsed(
                        hintText: subject,
                        hintStyle: TextStyle(
                          fontSize: 22,
                        )),
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                  Text(
                    hint,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ),
            iconButtonAfter
          ],
        ),
      ),
    );
  }
}
