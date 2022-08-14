import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stodo/classes/Users.dart';
import '../classes/User.dart';
import 'Profile.dart';

class Friends extends StatefulWidget {
  Friends({Key? key, required this.mainUserId}) : super(key: key);

  String mainUserId;
  String subText = "Enter username";
  bool nullBool = false;

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    User mainUser = Users.users[widget.mainUserId]!;
    List<User> friends = mainUser.getFriends;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Your friends"),
          centerTitle: true,
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
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
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
                                        const Text("Friend requests"),
                                        mainUser.friendRequest.isEmpty
                                            ? Padding(
                                          padding: const EdgeInsets.only(top: 40),
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: const TextSpan(children: [
                                              TextSpan(text: "There is no request\n\n\n",
                                                  style: TextStyle(fontSize: 30,color: Colors.black54)),
                                              TextSpan(text: "💌",style: TextStyle(fontSize: 100))
                                            ]),),
                                        )
                                            : Expanded(
                                          child: ListView.builder(
                                            itemCount: mainUser
                                                .friendRequest.length,
                                            itemBuilder:
                                                (context, index) {
                                              User user = mainUser
                                                  .friendRequest
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
                                                                    mainUserId: widget.mainUserId,
                                                                    userId: user.getId,
                                                                  ))),
                                                  leading:
                                                  const CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                    AssetImage(
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
                                                        onPressed: () {
                                                          setState(() =>
                                                              ignoreRequest(
                                                                  user));
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.check,
                                                          color: Colors
                                                              .green,
                                                          size: 25,
                                                        ),
                                                        onPressed: () {
                                                          setState(() =>
                                                              acceptRequest(
                                                                  user));
                                                        },
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
                  mainUser.friendRequest.isEmpty
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
            )
          ]),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            User friend = friends.elementAt(index);
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(friend.firstname),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/avatar.png"),
                  radius: 25,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // If the current tab is the first tab (the form tab)
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: const Center(
                                    child: Text(
                                        'Are you sure you want to remove this friend?')),
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
                                      removeFriend(friend);
                                      Navigator.pop(context);
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
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          var controller = TextEditingController();
          showModalBottomSheet(
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
                    child: SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Transform.rotate(
                                  angle: -0.5 * pi,
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 25,
                                  )),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      scrollController: ScrollController(),
                                      autofocus: true,
                                      controller: controller,
                                      textAlign: TextAlign.center,
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: "Enter friend username",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                              )),
                                      style: const TextStyle(fontSize: 25),
                                      onChanged: (String txt) {
                                        setState(() => checkUsername(txt));
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    widget.subText,
                                    style: TextStyle(
                                        color: widget.nullBool
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
                                    Users.searchByUsername(controller.text);
                                if (user == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("user not found")));
                                } else if (mainUser.getFriends.contains(user)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "this user is already your friend")));
                                } else {
                                  user.friendRequest.add(user);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "friend request send")));
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
    );
  }

  void removeFriend(User friend) {
    setState(() {
      Users.users[widget.mainUserId]!.removeFriend(friend: friend);
    });
  }

  void checkUsername(String txt) {
    setState(() {
      User? user = Users.searchByUsername(txt);
      if (user == null) {
        widget.subText = "username doesn't exist";
        widget.nullBool = true;
      } else {
        widget.subText =
            "user \"${user.firstname} ${user.lastname}\" found";
        widget.nullBool = false;
      }
    });
  }

  void acceptRequest(User friend) {
    User mainUser = Users.users[widget.mainUserId]!;
    setState(() {
      mainUser.friendRequest.remove(friend);
      mainUser.addFriend(friend);
      friend.addFriend(mainUser);
    });
    if (mainUser.friendRequest.isEmpty) Navigator.pop(context);
  }

  ignoreRequest(User user) {
    User mainUser = Users.users[widget.mainUserId]!;
    setState(() {
      mainUser.friendRequest.remove(user);
    });
    if (mainUser.friendRequest.isEmpty) Navigator.pop(context);
  }
}
