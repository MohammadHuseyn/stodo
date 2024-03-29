import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stodo/dart%20files/Profile.dart';
import '../classes/TaskList.dart';
import '../classes/User.dart';
import '../classes/Users.dart';
import 'HomePage.dart';
import 'TaskListPage.dart';
import 'dart:math';

class TaskListInformationPage extends StatefulWidget {
  TaskList taskList;
  String mainUserId;

  TaskListInformationPage({Key? key, required this.mainUserId, required this.taskList}) : super(key: key);

  @override
  State<TaskListInformationPage> createState() =>
      _TaskListInformationPageState();
}

class _TaskListInformationPageState extends State<TaskListInformationPage> {
  @override
  Widget build(BuildContext context) {
    // print(widget.mainUserId);
    User mainUser = Users.users[widget.mainUserId]!;
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    final children = <Widget>[
      const Center(
        child: Padding(
          child: const Text(
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
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(
                        mainUserId: widget.mainUserId,
                        userId: widget.taskList.users.elementAt(i).getId))),
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/avatar.png"),
            ),
            title: Text(
              widget.taskList.users.elementAt(i).firstname,
              textAlign: TextAlign.center,
            ),
            trailing:
                (!identical(widget.taskList.users.elementAt(i), mainUser) &&
                        widget.mainUserId == widget.taskList.creatorId)
                    ? IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // print(widget.mainUserId + " ::: " + widget.task.ownerId);
                          setState(() {
                            widget.taskList.users.removeAt(i);
                            scaffoldMessenger.hideCurrentSnackBar();
                            scaffoldMessenger.showSnackBar(
                                const SnackBar(content: Text("Tagged user removed")));
                          });
                        },
                      )
                    : null,
          ),
        ),
      );
    }
    children.add(const SizedBox(
      height: 70,
    ));
    children.add(ListTile(
      tileColor: Colors.green[800],
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Add someone",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
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
                content: Text("You haven't add any friends, request them.")))
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
                                  User user =
                                      mainUser.getFriends.elementAt(index);
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListTile(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile(
                                                  mainUserId: widget.mainUserId,
                                                  userId: user.getId))),
                                      leading: const CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage("assets/avatar.png"),
                                      ),
                                      title: Text(
                                        user.firstname,
                                        textAlign: TextAlign.center,
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: widget.taskList.users
                                                  .contains(user)
                                              ? Colors.green
                                              : null,
                                          size: 35,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            addUserFunc(user);
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
                                    child: const Icon(Icons.person_add),
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
    ));
    children.add(const SizedBox(
      height: 70,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.taskList.name),
        actions: [
          Center(
            child: Stack(
              children: [
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          builder: (context) =>
                              StatefulBuilder(builder: (context, setState) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: Transform.rotate(
                                              angle: -0.5 * pi,
                                              child: const Icon(
                                                Icons.arrow_back_ios_new,
                                                color: Colors.black54,
                                                size: 20,
                                              ))),
                                      const Text("Join requests"),
                                      widget.taskList.getJoinRequests.isEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 40),
                                              child: RichText(
                                                textAlign: TextAlign.center,
                                                text: const TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          "There is no request\n\n\n",
                                                      style: TextStyle(
                                                          fontSize: 30,color: Colors.black)),
                                                  TextSpan(
                                                      text: "💌",
                                                      style: TextStyle(
                                                          fontSize: 100))
                                                ]),
                                              ),
                                            )
                                          : Expanded(
                                              child: ListView.builder(
                                                itemCount: widget.taskList
                                                    .getJoinRequests.length,
                                                itemBuilder: (context, index) {
                                                  User user = widget
                                                      .taskList.getJoinRequests
                                                      .elementAt(index);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: ListTile(
                                                      onTap: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Profile(
                                                                            mainUserId:
                                                                                widget.mainUserId,
                                                                            userId:
                                                                                user.getId,
                                                                          ))),
                                                      leading:
                                                          const CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage(
                                                            "assets/avatar.png"),
                                                      ),
                                                      title: Text(
                                                        user.username,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      trailing: Wrap(
                                                        spacing: 5,
                                                        children: [
                                                          IconButton(
                                                              icon: const Icon(
                                                                Icons.clear,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      ignoreRequest(
                                                                          user))),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 25,
                                                            ),
                                                            onPressed: () =>
                                                                setState(() =>
                                                                    acceptRequest(
                                                                        user)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                              }));
                    },
                    icon: const Icon(Icons.emoji_people)),
                widget.taskList.getJoinRequests.isEmpty
                    ? Container(
                        height: 12,
                      )
                    : Container(
                        height: 12,
                        width: 12,
                        decoration: const BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                      )
              ],
            ),
          ),
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
                              child: const Text(
                                  'Are you sure you want to delete this tasklist?')),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              // Closes the dialog
                              child: const Text('No'),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
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
                                              mainUserId: widget.mainUserId,
                                              title: 'Stodo',
                                            )));

                                scaffoldMessenger.hideCurrentSnackBar();
                                scaffoldMessenger.showSnackBar(SnackBar(
                                  content:
                                      const Text("TaskList deleted successfully"),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () =>
                                        scaffoldMessenger.hideCurrentSnackBar(),
                                  ),
                                ));
                              },
                              child: const Text('Yes'),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
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
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share('I have a Task on ');
              }),
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
                        taskList: widget.taskList)));
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
                                userId: widget.taskList.creatorId))),
                    leading: const CircleAvatar(
                      backgroundImage: const AssetImage("assets/avatar.png"),
                      radius: 30,
                    ),
                    title: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "creator: ",
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextSpan(
                              text: Users.users[widget.taskList.creatorId]!
                                  .firstname,
                              style: const TextStyle(color: Colors.black))
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
                      leading: const Text("Name"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.taskList.name,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () {
                        if (widget.taskList.creatorId == widget.mainUserId) {
                          var controller = TextEditingController();
                          controller.text = widget.taskList.name;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 1,
                              maxLines: 1,
                              height: 120.0,
                              type: 'name',
                              hint: "Name of TaskList");
                        } else {
                          copy(widget.taskList.name,"Name");
                        }
                      },
                    ),
                    ListTile(
                      leading: const Text("Description"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.taskList.description,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () {
                        if (widget.taskList.creatorId == widget.mainUserId) {
                          var controller = TextEditingController();
                          controller.text = widget.taskList.description;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 3,
                              maxLines: 5,
                              height: 220.0,
                              type: 'description',
                              hint: "Description of TaskList");
                        } else {
                          copy(widget.taskList.description,"Description");
                        }
                      },
                    ),
                    ListTile(
                      leading: const Text("ED center\nor Company\n"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.taskList.educationCenter,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () {
                        if (widget.taskList.creatorId == widget.mainUserId) {
                          var controller = TextEditingController();
                          controller.text = widget.taskList.educationCenter;
                          textEditorBottomPopup(
                              controller: controller,
                              minLines: 1,
                              maxLines: 1,
                              height: 120.0,
                              type: 'educationCenter',
                              hint: "Education Center, Company, ...");
                        } else {
                          copy(widget.taskList.educationCenter,"ED center");
                        }
                      },
                    ),
                    ListTile(
                      leading: const Text("ED center\nor Company\ndescription\n"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: widget.taskList.educationCenterDescription ==
                                ""
                            ? const Text(
                                "no description",
                                style: TextStyle(color: Colors.grey),
                              )
                            : Text(
                                widget.taskList.educationCenterDescription,
                                textAlign: TextAlign.end,
                              ),
                      ),
                      onTap: () {
                        if (widget.taskList.creatorId == widget.mainUserId) {
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
                        } else {
                          copy(widget.taskList.educationCenterDescription,"Ed description");
                        }
                      },
                    ),
                    ListTile(
                      leading: const Text("Date created"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.taskList.dateCreated
                              .toString()
                              .substring(0, 16),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () => copy(widget.taskList.dateCreated.toString().substring(0, 16),"date created"),
                    ),
                    ListTile(
                      leading: const Text("ID"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.taskList.getId,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () => copy(widget.taskList.getId,'TaskList ID')
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
        case "name":
          widget.taskList.name = value.toString();
          valueUpdated();
          break;
        case "description":
          widget.taskList.description = value.toString();
          valueUpdated();
          break;
        case "delete":
          Users.users[widget.mainUserId]!.taskLists.remove(value as TaskList);
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
      content: const Text("Filed updated"),
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: const Radius.circular(20))),
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

  void addUserFunc(User user) {
    setState(() {
      widget.taskList.users.contains(user)
          ? widget.taskList.users.remove(user)
          : widget.taskList.users.add(user);
    });
  }

  ignoreRequest(User user) {
    setState(() => widget.taskList.removeJoinRequest(user));
  }

  acceptRequest(User user) {
    setState(() {
      widget.taskList.removeJoinRequest(user);
      widget.taskList.users.add(user);
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
