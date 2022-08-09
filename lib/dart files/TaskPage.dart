import 'package:share_plus/share_plus.dart';
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
    children.add(
      ListTile(
        tileColor: Colors.green[800],
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Tag someone",style: TextStyle(color: Colors.white),),
              SizedBox(width: 10,),
              Icon(Icons.add_circle,color: Colors.white,)
            ],
          ),
        ),
        onTap: (){

        },
      )
    );
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
              color: Colors.white,
            ),
            onPressed: () {
              bool sure = false;

              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: Center(
                              child: Text(
                                  'Are you sure you want to delete this task?')),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              // Closes the dialog
                              child: Text('No'),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 88, vertical: 15),
                                  primary: Colors.indigo),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                changeValues(
                                    type: "delete", value: widget.task);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskListPage(
                                            taskList: widget.taskList,
                                            mainUser: widget.mainUser)));

                                scaffoldMessenger.hideCurrentSnackBar();
                                scaffoldMessenger.showSnackBar(SnackBar(
                                  content: Text("Task deleted successfully"),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () =>
                                        scaffoldMessenger.hideCurrentSnackBar(),
                                  ),
                                ));
                              },
                              child: Text('Yes'),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 88, vertical: 15),
                                  primary: Colors.deepOrange),
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              icon: Icon(Icons.share),
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
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                setState(() => widget.task.stared = !widget.task.stared);

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
              icon: Icon(widget.task.stared ? Icons.star : Icons.star_border))
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskListPage(
                        mainUser: widget.mainUser, taskList: widget.taskList)));
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
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(50)),
                  child: ListTile(
                    tileColor:
                        widget.task.done ? Colors.green[800] : Colors.indigo,
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
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () =>
                              scaffoldMessenger.hideCurrentSnackBar(),
                        ),
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
                                setState(() {
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
          widget.taskList.tasks.remove(value as Task);
          valueUpdated();
      }
    });
  }

  void valueUpdated() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Filed updated"),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    ));
  }

  void addTask(Task task) {
    setState(() {
      widget.taskList.tasks.add(task);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskPage(
                  task: task,
                  mainUser: widget.mainUser,
                  taskList: widget.taskList)));
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
                            decoration: InputDecoration.collapsed(
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
                        setState(() {
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
