import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/Task.dart';
import '../classes/TaskList.dart';
import '../classes/User.dart';
import 'HomePage.dart';
import 'TaskListPage.dart';

class TaskListInformationPage extends StatefulWidget {
  TaskList taskList;
  User mainUser;

  TaskListInformationPage({required this.mainUser, required this.taskList});

  @override
  State<TaskListInformationPage> createState() =>
      _TaskListInformationPageState();
}

class _TaskListInformationPageState extends State<TaskListInformationPage> {
  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    final children = <Widget>[
      Center(
        child: Padding(
          child: Text(
            "Users",
            style: TextStyle(fontSize: 15),
          ),
          padding: EdgeInsets.only(top: 10),
        ),
      )
    ];
    for (int i = 0; i < widget.taskList.users.length; i++) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/avatar.png"),
            ),
            title: Text(
              widget.taskList.users.elementAt(i).firstname,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      if (i + 1 != widget.taskList.users.length) {
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
    children.add(ListTile(
      tileColor: Colors.green[800],
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add someone",
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
      onTap: () {},
    ));
    children.add(SizedBox(
      height: 70,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.taskList.name),
        actions: [
          IconButton(
            icon: Icon(
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
                          title: Center(
                              child: Text(
                                  'Are you sure you want to delete this tasklist?')),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              // Closes the dialog
                              child: Text('No'),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 42, vertical: 15),
                                  primary: Colors.indigo),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                changeValues(
                                    type: "delete", value: widget.taskList);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage(
                                              mainUser: widget.mainUser,
                                              title: 'Stodo',
                                            )));

                                scaffoldMessenger.hideCurrentSnackBar();
                                scaffoldMessenger.showSnackBar(SnackBar(
                                  content:
                                      Text("TaskList deleted successfully"),
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
                                      horizontal: 40, vertical: 15),
                                  primary: Colors.deepOrange),
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
          ),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share('I have a Task on ');
              }),
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
                        backgroundImage: AssetImage("assets/avatar.png"),
                        radius: 30,
                      ),
                      title: Center(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "creator: ",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextSpan(
                                text: widget.taskList.creator.firstname,
                                style: TextStyle(color: Colors.black))
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text("Name"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.taskList.name,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          var controller = TextEditingController();
                          controller.text = widget.taskList.name;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 1,
                              maxLines: 1,
                              height: 120.0,
                              type: 'name',
                              hint: "Name of TaskList");
                        },
                      ),
                      ListTile(
                        leading: Text("Description"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.taskList.description,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          var controller = TextEditingController();
                          controller.text = widget.taskList.description;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 3,
                              maxLines: 5,
                              height: 220.0,
                              type: 'description',
                              hint: "Description of TaskList");
                        },
                      ),
                      ListTile(
                        leading: Text("ED center\nor Company\n"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.taskList.educationCenter,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          var controller = TextEditingController();
                          controller.text = widget.taskList.educationCenter;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 1,
                              maxLines: 1,
                              height: 120.0,
                              type: 'educationCenter',
                              hint: "Education Center, Company, ...");
                        },
                      ),
                      ListTile(
                        leading: Text("ED center\nor Company\ndescription\n"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: widget.taskList.educationCenterDescription ==
                                  ""
                              ? Text(
                                  "no description",
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text(
                                  widget.taskList.educationCenterDescription,
                                  textAlign: TextAlign.end,
                                ),
                        ),
                        onTap: () {
                          var controller = TextEditingController();
                          controller.text =
                              widget.taskList.educationCenterDescription;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 3,
                              maxLines: 5,
                              height: 220.0,
                              type: 'educationCenterDescription',
                              hint:
                                  "Description for Education Center / Company");
                        },
                      ),
                      ListTile(
                        leading: Text("Date created"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.taskList.dateCreated
                                .toString()
                                .substring(0, 16),
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
        case "name":
          widget.taskList.name = value.toString();
          valueUpdated();
          break;
        case "description":
          widget.taskList.description = value.toString();
          valueUpdated();
          break;
        case "delete":
          widget.mainUser.taskLists.remove(value as TaskList);
          valueUpdated();
          break;
        case "educationCenter":
        case "educationCenterDescription":
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
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
                        child: TextField(
                          scrollController: ScrollController(),
                          minLines: minLines,
                          maxLines: maxLines,
                          autofocus: true,
                          controller: controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration.collapsed(
                              hintText: hint,
                              hintStyle: TextStyle(
                                fontSize: 22,
                              )),
                          style: TextStyle(fontSize: 25),
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
              ),
            );
          });
        });
  }
}
