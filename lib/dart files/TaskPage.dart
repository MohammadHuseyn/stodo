import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stodo/dart%20files/Profile.dart';
import 'package:stodo/main.dart';
import '../classes/Task.dart';
import '../classes/TaskList.dart';
import '../classes/User.dart';
import '../classes/Users.dart';
import 'TaskListPage.dart';
import 'dart:math';

class TaskPage extends StatefulWidget {
  Task task;
  String mainUserId;

  TaskPage({Key? key, required this.task, required this.mainUserId}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    User mainUser = Users.users[widget.mainUserId]!;
    // print(widget.mainUserId);
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    final children = <Widget>[
      const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Tagged users",
            style: TextStyle(fontSize: 15),
          ),
        ),
      )
    ];
    for (int i = 0; i < widget.task.tagged.length; i++) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/avatar.png"),
              ),
              title: Text(
                widget.task.tagged.elementAt(i).firstname,
                textAlign: TextAlign.center,
              ),
              trailing: (widget.task.ownerId == widget.mainUserId ||
                      widget.task.tagged.elementAt(i).getId ==
                          widget.mainUserId)
                  ? IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (widget.task.tagged.contains(mainUser)) {
                          // print(widget.mainUserId + " ::: " + widget.task.ownerId);
                          setState(() {
                            widget.task.tagged.removeAt(i);
                            scaffoldMessenger.hideCurrentSnackBar();
                            scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text("Tagged user removed")));
                          });
                        }
                      },
                    )
                  : null,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                          mainUserId: widget.mainUserId,
                          userId: widget.task.tagged.elementAt(i).getId)))),
        ),
      );
    }
    children.add(const SizedBox(
      height: 75,
    ));
    widget.task.tagged.contains(mainUser)
        ? children.add(ListTile(
            tileColor: Colors.green[800],
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Tag someone",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            onTap: () {
              scaffoldMessenger.hideCurrentSnackBar();
              mainUser.getFriends.isEmpty
                  ? scaffoldMessenger.showSnackBar(const SnackBar(
                      content:
                          Text("You haven't add any friends, request them.")))
                  : showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: Transform.rotate(
                                          angle: -0.5 * pi,
                                          child: const Icon(
                                            Icons.arrow_back_ios_new,
                                            size: 25,
                                          ))),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: mainUser.getFriends.length,
                                      itemBuilder: (context, index) {
                                        User friend = mainUser.getFriends
                                            .elementAt(index);
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ListTile(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                          mainUserId:
                                                              widget.mainUserId,
                                                          userId: friend.getId,
                                                        ))),
                                            leading: const CircleAvatar(
                                              radius: 25,
                                              backgroundImage: AssetImage(
                                                  "assets/avatar.png"),
                                            ),
                                            title: Text(
                                              friend.firstname,
                                              textAlign: TextAlign.center,
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: widget.task.tagged
                                                        .contains(friend)
                                                    ? Colors.green
                                                    : null,
                                                size: 35,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  tagFunc(friend);
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: FloatingActionButton(
                                          child: Icon(Icons.person_add),
                                          onPressed: () {}),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      });
            },
          ))
        : Container();
    children.add(const SizedBox(
      height: 70,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.task.title),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Center(
                              child: Text(
                                  'Are you sure you want to delete this task?')),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 42, vertical: 15),
                                  primary: Colors.indigo),
                              // Closes the dialog
                              child: const Text('No'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                changeValues(
                                    type: "delete", value: widget.task);
                                Navigator.pop(context);
                                scaffoldMessenger.hideCurrentSnackBar();
                                scaffoldMessenger.showSnackBar(SnackBar(
                                  content:
                                      const Text("Task deleted successfully"),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () =>
                                        scaffoldMessenger.hideCurrentSnackBar(),
                                  ),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  primary: Colors.deepOrange),
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
          ),
          IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share('I have a Task on ' +
                    widget.task.deadline.day.toString() +
                    ' of ' +
                    widget.task.deadline.month.toString() +
                    ', ' +
                    widget.task.deadline.year.toString() +
                    " named as " +
                    widget.task.title +
                    ":\n" +
                    widget.task.description);
              }),
          IconButton(
            onPressed: () {
              setState(() {
                widget.task.stared = !widget.task.stared;
                Users.users[widget.mainUserId]!.stared.add(widget.task);
              });

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(widget.task.stared
                    ? "Task set as stared"
                    : "Task Not set as stared"),
                action: SnackBarAction(
                  label: "Ok",
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ));
            },
            icon: Icon(widget.task.stared ? Icons.star : Icons.star_border),
            color: Colors.orange,
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskListPage(
                        mainUserId: widget.mainUserId,
                        taskList: widget.task.taskList)));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                mainUserId: widget.mainUserId,
                                userId: widget.task.ownerId))),
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("assets/avatar.png"),
                      radius: 30,
                    ),
                    title: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "owner: ",
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextSpan(
                              text:
                                  Users.users[widget.task.ownerId]!.firstname,
                              style: const TextStyle(color: Colors.black))
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(50)),
                child: ListTile(
                  tileColor:
                      widget.task.done ? Colors.green[800] : Colors.indigo,
                  title: Center(
                      child: Padding(
                    padding: EdgeInsets.all(widget.task.done ? 29 : 15),
                    child: (widget.task.done
                        ? const Text(
                            "Done",
                            style: TextStyle(
                                fontSize: 25, color: Colors.white),
                          )
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: "Not done yet :(\n\n",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              TextSpan(
                                  text: timeLeft(widget.task.deadline),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white))
                            ]),
                          )),
                  )),
                  onTap: () {
                    if (widget.task.tagged.contains(mainUser)) {
                      scaffoldMessenger.removeCurrentSnackBar();
                      setState(() {
                        widget.task.done = !widget.task.done;
                        Users.users[widget.mainUserId]!.taskPoint += 1;
                      });
                      scaffoldMessenger.showSnackBar(SnackBar(
                        content: Text("Task set as ${widget.task.done ? "Done" : "Undone"}"),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () =>
                              scaffoldMessenger.hideCurrentSnackBar(),
                        ),
                      ));
                    }
                  },
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Text("Title"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.task.title,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () {
                        if (widget.task.tagged.contains(mainUser)) {
                          var controller = TextEditingController();
                          controller.text = widget.task.title;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 1,
                              maxLines: 1,
                              height: 130.0,
                              type: 'title',
                              hint: "Title");
                        } else {
                          copy(widget.task.title,"Title");
                        }
                      },
                    ),
                    ListTile(
                      leading: const Text("Description"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.task.description,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () {
                        if (widget.task.tagged.contains(mainUser)) {
                          var controller = TextEditingController();
                          controller.text = widget.task.description;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 3,
                              maxLines: 5,
                              height: 270.0,
                              type: 'description',
                              hint: "Description");
                        } else {
                          copy(widget.task.description,"Description");
                        }
                      },
                    ),
                    ListTile(
                        leading: const Text("Deadline date"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.task.deadline.toString().substring(0, 16),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () async {
                          if (widget.task.tagged.contains(mainUser)) {
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
                                setState(() {
                                  changeValues(type: "date", value: deadline);
                                });
                              }
                            }
                          } else {
                            copy(widget.task.deadline.toString().substring(0, 16),"Deadline date");
                          }
                        }),
                    ListTile(
                      leading: const Text("Date created"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.task.dateCreated.toString().substring(0, 16),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () => copy(widget.task.dateCreated.toString().substring(0, 16),"Date created"),
                    ),
                    ListTile(
                      leading: Text("ID"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.task.getId,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () => copy(widget.task.getId,"Task ID"),
                    ),
                  ],
                ),
              ),
              Card(
                child: Wrap(children: children),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeValues({required String type, required var value}) {
    setState(() {
      switch (type) {
        case "title":
          widget.task.title = value.toString();
          valueUpdated();
          break;
        case "description":
          widget.task.description = value.toString();
          valueUpdated();
          break;
        case "date":
          widget.task.deadline = value;
          valueUpdated();
          break;
        case "delete":
          widget.task.taskList.tasks.remove(value as Task);
          valueUpdated();
      }
    });
  }

  void valueUpdated() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Filed updated"),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    ));
  }

  void addTask(Task task) {
    setState(() {
      widget.task.taskList.tasks.add(task);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskPage(
                    task: task,
                    mainUserId: widget.mainUserId,
                  )));
    });
  }

  Future<void> textEditorBottomPopup(
      {required TextEditingController controller,
      required int minLines,
      required int maxLines,
      required height,
      required String type,
      required String hint}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: height,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: TextField(
                          scrollController: ScrollController(),
                          minLines: minLines,
                          maxLines: maxLines,
                          autofocus: true,
                          controller: controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration.collapsed(
                              hintText: hint,
                              hintStyle: const TextStyle(
                                fontSize: 22,
                              )),
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            changeValues(type: type, value: controller.text);
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  String timeLeft(DateTime deadline) {
    Duration duration = deadline.difference(DateTime.now());
    if (duration.inDays > 100) {
      return "There is a lot of time left";
    } else if (duration.inDays > 1) {
      return "${duration.inDays} days left";
    } else if (duration.inHours > 1) {
      return "${duration.inHours} hours left";
    } else if (duration.inMinutes > 5) {
      return "${duration.inMinutes} minutes left";
    } else if (duration.inMinutes > 1) {
      return "few minutes left";
    } else {
      return "few seconds left";
    }
  }

  void tagFunc(User friend) {
    setState(() {
      widget.task.tagged.contains(friend)
          ? widget.task.tagged.remove(friend)
          : widget.task.tagged.add(friend);
    });
  }
  copy(String txt, String lable){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Clipboard.setData(
        ClipboardData(text: txt))
        .then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text("$lable copeied to clipboard"),
      action: SnackBarAction(
        label: "Ok",
        onPressed: () =>
            ScaffoldMessenger.of(context)
                .hideCurrentSnackBar(),
      ),
    )));
  }
}
