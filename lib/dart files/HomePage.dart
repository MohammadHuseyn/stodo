import 'dart:math';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stodo/dart%20files/Friends.dart';
import 'package:stodo/dart%20files/Profile.dart';
import 'package:stodo/dart%20files/Stared.dart';
import 'package:stodo/dart%20files/TaskListPage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../classes/TaskList.dart';
import '../classes/User.dart';
import '../classes/Users.dart';
import 'AddTaskList.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.mainUserId,
  }) : super(key: key);

  final String title;
  final String mainUserId;
  String subText = "";
  bool nullBool = false;
  String searchedTaskListOwnerId = "";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // print(widget.mainUserId);
    User mainUser = Users.users[widget.mainUserId]!;
    bool selected = false;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          hoverColor: Colors.green,
          child: const Icon(Icons.playlist_add, size: 30),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddTaskList(mainUserId: widget.mainUserId)));
          },
        ),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,
        drawer: Drawer(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.indigo,
                          blurRadius: 500,
                          spreadRadius: 0.01)
                    ]),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(
                                      mainUserId: widget.mainUserId,
                                      userId: widget.mainUserId))),
                          child: Card(
                            margin: const EdgeInsets.all(25),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                minLeadingWidth: 90,
                                leading: const CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        const AssetImage("assets/avatar.png")),
                                title: Text(
                                  mainUser.firstname,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(mainUser.username,
                                    style: const TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(
                                  Icons.edit_rounded,
                                  color: Colors.black,
                                ),
                                title: const Text("Edit profile"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile(
                                            mainUserId: widget.mainUserId,
                                            userId: widget.mainUserId))),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.black,
                                ),
                                title: const Text("New list"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTaskList(
                                            mainUserId: widget.mainUserId))),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                title: const Text("Search in TaskLists"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  Navigator.pop(context);
                                  var controller = TextEditingController();
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Container(
                                              height: 150,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(30),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Transform.rotate(
                                                          angle: -0.5 * pi,
                                                          child: const Icon(
                                                            Icons
                                                                .arrow_back_ios_new,
                                                            color:
                                                                Colors.black54,
                                                            size: 25,
                                                          )),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: TextField(
                                                              scrollController:
                                                                  ScrollController(),
                                                              autofocus: true,
                                                              controller:
                                                                  controller,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              decoration: const InputDecoration
                                                                      .collapsed(
                                                                  hintText:
                                                                      "Enter TaskList ID",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                  )),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          25),
                                                              onChanged:
                                                                  (String txt) {
                                                                setState(() =>
                                                                    checkTaskList(
                                                                        txt));
                                                              },
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            widget.subText,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: widget
                                                                        .nullBool
                                                                    ? Colors.red
                                                                    : null),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.search,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        User? user =
                                                            Users.users[widget
                                                                .searchedTaskListOwnerId]!;

                                                        if (user == null) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: const Text(
                                                                      "There is no tasklist"),
                                                                  action: SnackBarAction(
                                                                      label:
                                                                          "Ok",
                                                                      onPressed:
                                                                          () =>
                                                                              ScaffoldMessenger.of(context).hideCurrentSnackBar())));
                                                        } else {
                                                          late TaskList
                                                              taskList;
                                                          for (var element in user.taskLists) {
                                                            if (element.getId ==
                                                                controller
                                                                    .text) {
                                                              taskList =
                                                                  element;
                                                              continue;
                                                            }
                                                          }
                                                          if (mainUser.taskLists
                                                              .contains(
                                                                  taskList)) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: const Text(
                                                                  "you already joined this taskList"),
                                                              action:
                                                                  SnackBarAction(
                                                                label: "Ok",
                                                                onPressed: () =>
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .hideCurrentSnackBar(),
                                                              ),
                                                            ));
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: const Text(
                                                                  "join request sent"),
                                                              action:
                                                                  SnackBarAction(
                                                                label: "Ok",
                                                                onPressed: () =>
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .hideCurrentSnackBar(),
                                                              ),
                                                            ));
                                                            taskList
                                                                .addJoinRequest(
                                                                    user);
                                                          }
                                                        }
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.group,
                                  color: Colors.black,
                                ),
                                title: const Text("Friends"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Friends(
                                            mainUserId: widget.mainUserId))),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.star,
                                  color: Colors.black,
                                ),
                                title: const Text("Stared"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Stared(
                                              mainUserId: widget.mainUserId,
                                            ))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(
                                  Icons.person_add,
                                  color: Colors.black,
                                ),
                                hoverColor: Colors.orange,
                                title: const Text("Invite friends"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  Share.share(
                                      "hey! have you used Stodo? try it, it's amazing!\ngithub.com/MohammadHuseyn/stodo");
                                },
                              ),
                              ListTile(
                                  leading: const Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  hoverColor: Colors.green,
                                  title: const Text("Contact us"),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_right),
                                  onTap: () => launchUrl(Uri.parse(
                                      "mailto:amini4job@gmail.com?subject=Stodo contact us email"))),
                              ListTile(
                                hoverColor: Colors.red,
                                leading: const Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                                title: const Text("Log out"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () => showSearch(
                    context: context,
                    delegate:
                        HomePageSearchDelegate(taskLists: mainUser.taskLists)),
                icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: mainUser.taskLists.length,
            itemBuilder: (context, index) {
              TaskList taskList = mainUser.taskLists.elementAt(index);
              return Card(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskListPage(
                                    taskList:
                                    taskList,
                                    mainUserId: widget.mainUserId,
                                  ))),
                      title: Text(
                        taskList.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(taskList
                              .description
                              .split('\n')
                              .elementAt(0) +
                          (taskList
                                      .description
                                      .split('\n')
                                      .length >
                                  1
                              ? "..."
                              : "")),
                      trailing: Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Text(
                            taskList
                                .users
                                .length
                                .toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Icon(
                            Icons.people,
                            size: 30,
                          )
                        ],
                      )));
            },
          ),
        ));
  }

  void checkTaskList(String txt) {
    setState(() {
      for (int i = 0; i < Users.users.length; i++) {
        User user = Users.users.values.elementAt(i);
        for (int j = 0; j < user.taskLists.length; j++) {
          TaskList taskList = user.taskLists.elementAt(j);
          if (taskList.getId == txt) {
            widget.subText = "TaskList \"" +
                taskList.name +
                "\" which belongs to \"" +
                user.username +
                "\" found";
            widget.nullBool = false;
            widget.searchedTaskListOwnerId = user.getId;
            return;
          }
        }
      }
      widget.subText = "Tasklist could not be found";
      widget.nullBool = true;
      widget.searchedTaskListOwnerId = "";
    });
  }
}

class HomePageSearchDelegate extends SearchDelegate {
  HomePageSearchDelegate({required this.taskLists});

  List<TaskList> taskLists;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query == "" ? close(context, null) : query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<TaskList> searchResults = taskLists.where((element) {
      final result = element.name.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            searchResults.elementAt(index).name,
          ),
          onTap: () {
            query = searchResults.elementAt(index).name;
            showResults(context);
          },
        );
      },
    );
  }
}
