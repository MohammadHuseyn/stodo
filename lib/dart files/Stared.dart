import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stodo/classes/Users.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../classes/Task.dart';
import '../classes/User.dart';
import 'TaskPage.dart';

class Stared extends StatefulWidget {
  Stared({required this.mainUserId});

  String mainUserId;

  @override
  State<Stared> createState() => _StaredState();
}

class _StaredState extends State<Stared> {
  @override
  Widget build(BuildContext context) {
    User mainUser = Users.users[widget.mainUserId]!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stared"),
        centerTitle: true,
      ),
      body: mainUser.stared.isEmpty?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("There is no stared task",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30
            ),),
          ),
          const SizedBox(height: 30,),
          Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.stars_rounded,color: Colors.orange,size: 175,),
              const Icon(Icons.question_mark,color: Colors.orange,size: 50,)
            ],
          ),
        ],
      ) :
      ListView.builder(
        itemCount: mainUser.stared.length,
        itemBuilder: (context,index){
          Task task = mainUser.stared.elementAt(index);
          if(!task.taskList.tasks.contains(task)) {
            mainUser.stared.remove(task);
          }
          return Card(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Slidable(
                closeOnScroll: true,
                key: UniqueKey(),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  dismissible: DismissiblePane(
                      motion: const DrawerMotion(),
                      onDismissed: () {
                        Task undo = task;
                        deleteSlideAction(undo);
                      }),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Task undo = task;
                        deleteSlideAction(undo);
                      },
                      autoClose: true,
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.star,
                      label: 'Remove star',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Share.share('I have a Task on ' +
                            task.deadline.day.toString() +
                            ' of ' +
                            task.deadline.month.toString() +
                            ', ' +
                            task.deadline.year.toString() +
                            " named as " +
                            task.title +
                            ":\n" +
                            task.description);
                      },
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Share',
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(
                            task: task,
                            mainUserId: widget.mainUserId,

                          ))),
                  subtitle: Wrap(spacing: 5, children: [
                    Timeago(
                        builder: (context, value) => Text('$value, '),
                        date: task.dateCreated),
                    Text(task.description.split('\n').elementAt(0) +
                        (task.description.split('\n').length > 1
                            ? "..."
                            : "")),
                  ]),
                  leading: Ink(
                    decoration: const ShapeDecoration(
                        shape: const CircleBorder(), color: Colors.white),
                    child: IconButton(
                      icon: Icon(
                        task.done
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          task.done = !task.done;
                          Users.users[widget.mainUserId]!.taskPoint += 1;
                        });
                      },
                    ),
                  ),
                  trailing: const CircleAvatar(
                    backgroundImage: AssetImage("assets/avatar.png"),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Wrap(spacing: 8, children: [
                      Text(
                        task.title,
                        style: TextStyle(
                            decoration: task.done
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      task.stared
                          ? Transform.rotate(
                        angle: pi - 50,
                        child: const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                      )
                          : const Text("")
                    ]),
                  ),
                  tileColor: task.done ? Colors.black12 : null,
                ),
              ));
        },
      ),
    );
  }
  void deleteSlideAction(Task undo) {
    setState(() {
      Users.users[widget.mainUserId]!.stared.remove(undo);
    });
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Task deleted from stared'),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              scaffold.hideCurrentSnackBar;
              addTask(undo);
            }),
      ),
    );
  }

  void addTask(Task undo) {
    setState((){
      Users.users[widget.mainUserId]!.stared.add(undo);
    });
  }
}
