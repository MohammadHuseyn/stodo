import 'package:flutter/material.dart';

import '../classes/TaskList.dart';
import '../classes/User.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key? key,
      required this.title,
      required this.mainUser,
      required this.taskLists})
      : super(key: key);

  final String title;
  final User mainUser;
  List<TaskList> taskLists;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Card(
                          margin: const EdgeInsets.all(25),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircleAvatar(
                                  minRadius:
                                      MediaQuery.of(context).size.width * 0.16,
                                  backgroundImage:
                                      const AssetImage("avatar.png"),
                                ),
                              ),
                              SizedBox(
                                // height: 100,
                                width: 150,
                                child: ListTile(
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit_rounded),
                                    onPressed: () {},
                                  ),
                                  title: const Text(
                                    "Name",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  subtitle: const Text("username",
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ),
                            ],
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
                                onTap: () {},
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
                                onTap: () {},
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
            IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: widget.taskLists.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){},
                child: Card(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                  child: ListTile(
                    title: Text(widget.taskLists.elementAt(index).name,style: TextStyle(fontSize: 18),),
                    subtitle: Text(widget.taskLists.elementAt(index).description),
                    trailing: Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text(widget.taskLists.elementAt(index).users.length.toString(),style: TextStyle(fontSize: 18),),
                        Icon(Icons.people,size: 30,)
                      ],
                    )
                  ),
                ),
              );
            },
          ),
        ));
  }
}
