import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/Task.dart';
import '../classes/TaskList.dart';
import '../classes/User.dart';
import 'TaskListPage.dart';

class TaskPage extends StatefulWidget {
  Task task;
  TaskList taskList;
  User mainUser;

  TaskPage(
      {required this.task, required this.mainUser, required this.taskList});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    final children = <Widget>[
      Center(
        child: Padding(
          child: Text(
            "Tagged users",
            style: TextStyle(fontSize: 15),
          ),
          padding: EdgeInsets.only(top: 10),
        ),
      )
    ];
    for (int i = 0; i < widget.task.tagged.length; i++) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("avatar.png"),
            ),
            title: Text(
              widget.task.tagged.elementAt(i).firstname,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      if (i + 1 != widget.task.tagged.length) {
        children.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            color: Colors.black54,
          ),
        ));
      }
    }
    children.add(SizedBox(
      height: 70,
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                changeValues(type: "delete", value: widget.task);
              });
            },
          )
        ],
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskListPage(mainUser: widget.mainUser, taskList: widget.taskList)));
            },
      ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("avatar.png"),
                        radius: 30,
                      ),
                      title: Center(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "owner: ",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextSpan(text: widget.task.owner.firstname)
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    tileColor: widget.task.done ? Colors.green : Colors.indigo,
                    title: Center(
                        child: Padding(
                      child: (widget.task.done
                          ? Text(
                              "Done",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            )
                          : RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Not done yet :(\n\n",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                TextSpan(
                                    text: timeLeft(widget.task.deadline),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white))
                              ]),
                            )),
                      padding: EdgeInsets.all(widget.task.done ? 29 : 15),
                    )),
                    onTap: () {
                      scaffoldMessenger.removeCurrentSnackBar();
                      setState(() {
                        widget.task.done = !widget.task.done;
                      });
                      scaffoldMessenger.showSnackBar(SnackBar(
                        content: Text("Task set as " +
                            (widget.task.done ? "Done" : "Undone")),
                      ));
                    },
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text("Title"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.task.title,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          var controller = TextEditingController();
                          controller.text = widget.task.title;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 1,
                              maxLines: 1,
                              height: 120,
                              type: 'title');
                        },
                      ),
                      ListTile(
                        leading: Text("Description"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.task.description,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          var controller = TextEditingController();
                          controller.text = widget.task.description;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 3,
                              maxLines: 5,
                              height: 220,
                              type: 'description');
                        },
                      ),
                      ListTile(
                          leading: Text("Deadline date"),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget.task.deadline.toString().substring(0, 16),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          onTap: () async {
                            DateTime deadline = widget.task.deadline;
                            final DateTime? value = await showDatePicker(
                                currentDate: widget.task.deadline,
                                context: context,
                                initialDate: deadline,
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2040),
                                confirmText: "Next");
                            if (value != null) {
                              final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: deadline.hour,
                                    minute: deadline.minute),
                                initialEntryMode: TimePickerEntryMode.dial,
                                confirmText: "Set",
                              );
                              if (time != null) {
                                deadline = DateTime(value.year, value.month,
                                    value.day, time.hour, time.minute);
                                setState((){
                                  changeValues(type: "date", value: deadline);
                                });
                              }
                            }
                          }),
                      ListTile(
                        leading: Text("Date created"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.task.dateCreated.toString().substring(0, 16),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Container(
                    child: Wrap(children: children),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeValues({required String type, required var value}) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    setState(() {
      switch (type) {
        case "title":
          widget.task.title = value.toString();
          break;
        case "description":
          widget.task.description = value.toString();
          break;
        case "date":
          widget.task.deadline = value;
          break;
        case "delete":
      }
    });
  }

  void addTask(Task task) {
    setState(() {
      // scaffoldMessenger.removeCurrentSnackBar();
      widget.taskList.tasks.add(task);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskPage(
                  task: task,
                  mainUser: widget.mainUser,
                  taskList: widget.taskList)));
      // scaffoldMessenger.showSnackBar(SnackBar(content: Text("Task added")));
    });
  }

  Future<void> textEditorBottomPopup({
    required TextEditingController controller,
    required int minLines,
    required int maxLines,
    required height,
    required String type,
  }) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            scrollController: ScrollController(),
                            minLines: minLines,
                            maxLines: maxLines,
                            autofocus: true,
                            controller: controller,
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration.collapsed(
                                hintText: 'Title',
                                hintStyle: TextStyle(
                                  fontSize: 22,
                                )),
                            style: TextStyle(fontSize: 25),
                          ),
                          Spacer(),
                          Text(
                            "Select a title for you task and type it",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState((){
                          changeValues(type: type, value: controller.text);
                        });
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  String timeLeft(DateTime deadline) {
    Duration duration = deadline.difference(DateTime.now());
    if (duration.inDays > 100)
      return "There is a lot of time left";
    else if (duration.inDays > 1)
      return duration.inDays.toString() + " days left";
    else if (duration.inHours > 1)
      return duration.inHours.toString() + " hours left";
    else if (duration.inMinutes > 5)
      return duration.inMinutes.toString() + " minutes left";
    else if (duration.inMinutes > 1)
      return "few minutes left";
    else
      return "few seconds left";
  }
}
