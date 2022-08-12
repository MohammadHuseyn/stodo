import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stodo/dart%20files/Profile.dart';
import 'package:stodo/dart%20files/TaskListPage.dart';

import '../classes/TaskList.dart';
import '../classes/User.dart';
import '../classes/Users.dart';
import 'AddTaskList.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.mainUserId,
  }) : super(key: key);

  final String title;
  final String mainUserId;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // print(widget.mainUserId);
    User mainUser = Users.users[widget.mainUserId]!;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          hoverColor: Colors.green,
          child: Icon(Icons.playlist_add, size: 30),
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
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.indigo,
                          blurRadius: 500,
                          spreadRadius: 0.01)
                    ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                          margin: const EdgeInsets.all(25),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile(
                                          mainUserId: widget.mainUserId,
                                          userId: widget.mainUserId))),
                              minLeadingWidth: 90,
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage("assets/avatar.png")),
                              title: Text(
                                "Name",
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text("username",
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
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
                                onTap: () {},
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
                                  Icons.list,
                                  color: Colors.black,
                                ),
                                title: const Text("All lists"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.group,
                                  color: Colors.black,
                                ),
                                title: const Text("Friends"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.bookmark,
                                  color: Colors.black,
                                ),
                                title: const Text("Highlighted"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                ),
                                title: const Text("Setting"),
                                trailing:
                                    const Icon(Icons.keyboard_arrow_right),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                                onTap: () {},
                              ),
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
                icon: Icon(Icons.search_rounded))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: mainUser.taskLists.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Card(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskListPage(
                                    taskList:
                                        mainUser.taskLists.elementAt(index),
                                    mainUserId: widget.mainUserId,
                                  ))),
                      title: Text(
                        mainUser.taskLists.elementAt(index).name,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(mainUser.taskLists
                              .elementAt(index)
                              .description
                              .split('\n')
                              .elementAt(0) +
                          (mainUser.taskLists
                                      .elementAt(index)
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
                            mainUser.taskLists
                                .elementAt(index)
                                .users
                                .length
                                .toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(
                            Icons.people,
                            size: 30,
                          )
                        ],
                      )),
                ),
              );
            },
          ),
        ));
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
    return Container(
      child: ListView.builder(
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
      ),
    );
  }
}
