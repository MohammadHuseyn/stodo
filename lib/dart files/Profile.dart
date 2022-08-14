import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/User.dart';
import '../classes/Users.dart';

class Profile extends StatefulWidget {
  String userId;
  String mainUserId;

  Profile({Key? key, required this.mainUserId, required this.userId}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User mainUser = Users.users[widget.mainUserId]!;
    User user = Users.users[widget.userId]!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(user.firstname),
        actions: [
          IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share('this is my profile on Stodo');
              }),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("assets/avatar.png"),
                      radius: 30,
                    ),
                    title: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "username: ",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          TextSpan(
                              text: user.username,
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
                        leading: const Text("Firstame"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            user.firstname,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          if (widget.mainUserId == widget.userId) {
                            var controller = TextEditingController();
                            controller.text = user.firstname;
                            textEditorBottomPopup(
                                controller: controller,
                                minLines: 1,
                                maxLines: 1,
                                height: 120.0,
                                type: 'firstname',
                                hint: "your firstname");
                          } else {
                            copy(user.firstname,"firstname");
                          }
                        }),
                    ListTile(
                        leading: const Text("Lastname"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            user.lastname,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          if (widget.mainUserId == widget.userId) {
                            var controller = TextEditingController();
                            controller.text = user.lastname;
                            textEditorBottomPopup(
                                controller: controller,
                                minLines: 3,
                                maxLines: 5,
                                height: 90.0,
                                type: 'lastname',
                                hint: "your lastname");
                          } else {
                            copy(user.lastname,"lastname");
                          }
                        }),
                    ListTile(
                        leading: const Text("\nBio\n"),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            user.bio,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          if (widget.mainUserId == widget.userId) {
                            var controller = TextEditingController();
                            controller.text = user.bio;
                            textEditorBottomPopup(
                                controller: controller,
                                minLines: 1,
                                maxLines: 3,
                                height: 220.0,
                                type: 'bio',
                                hint: "a biography about yourself");
                          } else {
                            copy(user.bio,"bio");
                          }
                        }),
                    widget.mainUserId == widget.userId
                        ? ListTile(
                            leading: const Text("Password"),
                            title: const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Hidden",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            onTap: () {},
                          )
                        : Container(),
                    widget.mainUserId == widget.userId
                        ? ListTile(
                            leading: const Text("Number of friends"),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                user.getFriends.length.toString(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            onTap: () {},
                          )
                        : Container(),
                    ListTile(
                      leading: const Text("Task point"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          user.taskPoint.floor().toString(),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () => copy(user.taskPoint.toString(),"User task point"),
                    ),
                    ListTile(
                      leading: const Text("Date joined"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          user.dateJoined.toString().substring(0, 16),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () => copy(user.dateJoined.toString().substring(0, 16),"Date joined"),
                    ),
                    ListTile(
                      leading: const Text("ID"),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          user.getId,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      onTap: () => copy(user.getId,"User ID"),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Center(
                        child: const Text("Share this profile"),
                      ),
                      leading: const Icon(
                        Icons.share,
                        color: Colors.blue,
                      ),
                      onTap: (){
                        Share.share("${mainUser.firstname} ${mainUser.lastname} with username \"${mainUser.username}\" is on Stodo"
                            "\ntask points: ${mainUser.taskPoint}\nid: ${mainUser.getId}\n");
                      },
                    ),
                    widget.mainUserId == widget.userId
                        ? const ListTile(
                            title: const Center(
                              child: Text("Login or SignUp another account"),
                            ),
                            leading: const Icon(
                              Icons.login,
                              color: Colors.orange,
                            ),
                          )
                        : const ListTile(
                            title: const Center(
                              child: Text("Send friend request"),
                            ),
                            leading: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                          ),
                    widget.mainUserId == widget.userId
                        ? const ListTile(
                            title: Center(
                              child: Text("Log Out this account"),
                            ),
                            leading: Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                          )
                        : const ListTile(
                            title: Center(
                              child: Text("Contact him/her"),
                            ),
                            leading: Icon(
                              Icons.call,
                              color: Colors.orange,
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeValues({required String type, required var value}) {
    User user = Users.users[widget.userId]!;
    setState(() {
      switch (type) {
        case "firstname":
          user.firstname = value.toString();
          valueUpdated();
          break;
        case "lastname":
          user.lastname = value.toString();
          valueUpdated();
          break;
        case "bio":
          user.bio = value.toString();
          valueUpdated();
          break;
        case "password":
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
            borderRadius: const BorderRadius.only(
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
                                fontSize: 15,
                              )),
                          style: const TextStyle(fontSize: 20),
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
