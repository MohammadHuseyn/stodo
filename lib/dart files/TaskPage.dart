import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/Task.dart';

class TaskPage extends StatefulWidget {
  Task task;

  TaskPage({required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        centerTitle: true,
      ),
      body: Container(
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
                  title: Center(
                      child: Padding(
                    child: (widget.task.done
                        ? Text(
                            "Done",
                            style: TextStyle(fontSize: 25),
                          )
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Not done yet :(\n\n",
                                  style: TextStyle(fontSize: 20)),
                              TextSpan(
                                  text: timeLeft(widget.task.deadline),
                                  style: TextStyle(fontSize: 15))
                            ]),
                          )),
                    padding: EdgeInsets.all(15),
                  )),
                  onTap: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    setState(() {
                      widget.task.done = !widget.task.done;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                          widget.task.deadline.toString(),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Text("Date created"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.task.dateCreated.toString(),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: SingleChildScrollView(
                  child: Container(
                      height: children.length / 2 * 85 >=
                              MediaQuery.of(context).size.height - 490
                          ? MediaQuery.of(context).size.height - 490
                          : children.length / 2 * 85,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: children,
                        ),
                      )),
                ),
              )
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
          break;
        case "description":
          widget.task.description = value.toString();
          break;
        case "date": print(value.toString());
      }
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
                        changeValues(type: type, value: controller.text);
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
