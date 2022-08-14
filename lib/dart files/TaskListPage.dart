import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stodo/classes/Users.dart';
import 'package:stodo/dart%20files/TaskListInformationPage.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import '../classes/Task.dart';
import '../classes/TaskList.dart';
import '../classes/User.dart';
import 'dart:math';
import 'TaskPage.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({Key? key, required this.taskList, required this.mainUserId,}) : super(key: key);

  TaskList taskList;
  String mainUserId;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    // print(widget.mainUserId);
    // widget.taskList.sortTasksInDate();
    var titleC = TextEditingController(), descC = TextEditingController();
    // var focusNode = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Center(
                child: Text(
              widget.taskList.name,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )),
            subtitle: Center(
                child: Text(
              widget.taskList.users.length.toString() +
                  (widget.taskList.users.length <= 1 ? " user" : " users"),
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            )),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskListInformationPage(
                      mainUserId: widget.mainUserId, taskList: widget.taskList)),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => Clipboard.setData(
                ClipboardData(text: widget.taskList.getId))
                .then((value) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
              content: const Text("ID copeied to clipboard"),
              action: SnackBarAction(
                label: "Ok",
                onPressed: () =>
                    ScaffoldMessenger.of(context)
                        .hideCurrentSnackBar(),
              ),
            ))),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: widget.taskList.tasks.length,
                itemBuilder: (context, index) {
                  Task task = widget.taskList.tasks.elementAt(index);
                  return Card(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Slidable(
                        closeOnScroll: true,
                        key: UniqueKey(),
                        startActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          dismissible: DismissiblePane(
                              motion: const DrawerMotion(),
                              onDismissed: () {
                                Task undo = task;
                                deleteSlideAction(undo);
                              }),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Task undo = task;
                                deleteSlideAction(undo);
                              },
                              autoClose: true,
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              onPressed: (context) {
                                setState(() {
                                  task.stared = !task.stared;
                                  Users.users[widget.mainUserId]!.stared.add(task);
                                });
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(task.stared
                                      ? "Task set as stared"
                                      : "Task Not set as stared"),
                                  action: SnackBarAction(
                                    label: "Ok",
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ));
                              },
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              icon: Icons.star,
                              label: 'Star',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Share.share('I have a Task on ' +
                                    task.deadline.day.toString() +
                                    ' of ' +
                                    task.deadline.month.toString() +
                                    ', ' +
                                    task.deadline.year.toString() +
                                    " named as " +
                                    task.title +
                                    ":\n" +
                                    task.description);
                              },
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              icon: Icons.share,
                              label: 'Share',
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskPage(
                                        task: task,
                                        mainUserId: widget.mainUserId,
                                      ))),
                          subtitle: Wrap(spacing: 5, children: [
                            Timeago(
                                builder: (context, value) => Text('$value, '),
                                date: task.dateCreated),
                            Text(task.description.split('\n').elementAt(0) +
                                (task.description.split('\n').length > 1
                                    ? "..."
                                    : "")),
                          ]),
                          leading: Ink(
                            decoration: const ShapeDecoration(
                                shape: const CircleBorder(), color: Colors.white),
                            child: IconButton(
                              icon: Icon(
                                task.done
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  task.done = !task.done;
                                  Users.users[widget.mainUserId]!.taskPoint += 1;
                                });
                              },
                            ),
                          ),
                          trailing: const CircleAvatar(
                            backgroundImage: AssetImage("assets/avatar.png"),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Wrap(spacing: 8, children: [
                              Text(
                                task.title,
                                style: TextStyle(
                                    decoration: task.done
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
                              task.stared
                                  ? Transform.rotate(
                                      angle: pi - 50,
                                      child: const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                    )
                                  : const Text("")
                            ]),
                          ),
                          tileColor: task.done ? Colors.black12 : null,
                        ),
                      ));
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                child: const Text(
                  "add a new task",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 25)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20)),
                      ),
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return bottomSheetWidget(titleC,
                              hint: "Select a title for you task and type it",
                              subject: " Title ",
                              iconButtonAfter: IconButton(
                                icon: const Icon(
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
                                          ownerId: widget.mainUserId,
                                      );
                                    });
                                    Navigator.pop(context);

                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: const Radius.circular(20)),
                                        ),
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return bottomSheetWidget(descC,
                                                hint:
                                                    "Make a description for you task",
                                                subject: " Description ",
                                                iconButtonAfter: IconButton(
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 25,
                                                    color: Colors.teal,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      newTask.description =
                                                          descC.text;
                                                      addTask(newTask);
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                iconButtonBefore: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
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
                                      child: const Icon(
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

  void addTask(Task task) {
    setState(() {
      widget.taskList.tasks.add(task);
      // widget.taskList.sortTasksInDate();
      task.taskList = widget.taskList;
    });
  }

  void deleteSlideAction(Task undo) {
    setState(() {
      widget.taskList.tasks.remove(undo);
    });
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              scaffold.hideCurrentSnackBar;
              addTask(undo);
            }),
      ),
    );
  }

  Widget bottomSheetWidget(TextEditingController controller,
      {required IconButton iconButtonAfter,
      required IconButton iconButtonBefore,
      required String subject,
      required String hint}) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(30),
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
                          hintStyle: const TextStyle(
                            fontSize: 22,
                          )),
                      style: const TextStyle(fontSize: 25),
                    ),
                    const Spacer(),
                    Text(
                      hint,
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              iconButtonAfter
            ],
          ),
        ),
      ),
    );
  }
}
