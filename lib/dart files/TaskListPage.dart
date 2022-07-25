import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../classes/Task.dart';
import '../classes/TaskList.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({required this.taskList});
  TaskList taskList;
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
              title: Center(
                  child: Text(widget.taskList.name,style: TextStyle(color: Colors.white,fontSize: 20),)),
              subtitle: Center(child: Text(widget.taskList.users.length.toString() + (widget.taskList.users.length <= 1? " user":" users"),style: TextStyle(color: Colors.white70,fontSize: 15),)),),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: widget.taskList.tasks.length,
          itemBuilder: (context,index){
            Task task = widget.taskList.tasks.elementAt(index);
            return Card(
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              child: ListTile(
                subtitle: Wrap(
                    spacing: 5,
                    children: [
                  Timeago(builder: (context, value) => Text(value + ', '), date: task.dateCreated),
                  Text(task.description),
              ]),
                leading: IconButton(
                  icon: Icon(task.done?Icons.check_circle:Icons.radio_button_unchecked,color: Colors.green,),
                  onPressed: () {
                    setState((){
                      task.done = !task.done;
                    });
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(task.title),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
