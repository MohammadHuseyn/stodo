import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
                  decoration: new BoxDecoration(boxShadow: [
                    new BoxShadow(
                        color: Colors.indigo, blurRadius: 500, spreadRadius: 0.01)
                  ]),
                  child: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.all(25),
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
                                backgroundImage: const AssetImage("avatar.png"),
                              ),
                            ),
                            Container(
                              // height: 100,
                              width: 150,
                              child: ListTile(
                                trailing: IconButton(
                                  icon: Icon(Icons.edit_rounded),
                                  onPressed: (){},
                                ),
                                title: Text("Name",style: TextStyle(fontSize: 24),),
                                subtitle: Text("username",style: TextStyle(fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.edit_rounded,
                                color: Colors.black,
                              ),
                              title: Text("Edit profile"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.playlist_add,
                                color: Colors.black,
                              ),
                              title: Text("New list"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.list,
                                color: Colors.black,
                              ),
                              title: Text("All lists"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.group,
                                color: Colors.black,
                              ),
                              title: Text("Friends"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.bookmark,
                                color: Colors.black,
                              ),
                              title: Text("Highlited"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              title: Text("Setting"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.person_add,
                                color: Colors.black,
                              ),
                              hoverColor: Colors.orange,
                              title: Text("Invite friends"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              hoverColor: Colors.green,
                              title: Text("Contact us"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              hoverColor: Colors.red,
                              leading: Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              title: Text("Log out"),
                              trailing: Icon(Icons.keyboard_arrow_right),
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
          )
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container());
  }
}
