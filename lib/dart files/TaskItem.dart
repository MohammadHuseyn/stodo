import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../classes/Task.dart';
import '../classes/TaskList.dart';
import 'TaskPage.dart';

class TaskItem extends StatefulWidget {
  TaskItem({required this.task, required this.taskList});

  Task task;
  TaskList taskList;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Slidable(
        closeOnScroll: true,
        key: UniqueKey(),
        child: ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(task: widget.task,))),
          subtitle: Wrap(spacing: 5, children: [
            Timeago(
                builder: (context, value) => Text(value + ', '),
                date: widget.task.dateCreated),
            Text(
                widget.task.description.split('\n').elementAt(0)
                  + (widget.task.description.split('\n').length > 1 ? "..." : "")
            ),
          ]),
          leading:  Ink(
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.white
            ),
            child: IconButton(
              icon: Icon(
                widget.task.done
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  widget.task.done = !widget.task.done;
                });
              },
            ),
          ),
        trailing: CircleAvatar(
          backgroundImage:
          const AssetImage("avatar.png"),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            widget.task.title,
            style: TextStyle(
                decoration: widget.task.done
                    ? TextDecoration.lineThrough
                    : null),
          ),
        ),
        tileColor: widget.task.done ? Colors.black12 : null,
      ),
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        dismissible: DismissiblePane(
            motion: DrawerMotion(),
            onDismissed: () {
              Task undo = widget.task;
              deleteSlideAction(undo);
            }),
        children: [
          SlidableAction(
            onPressed: (context) {
              Task undo = widget.task;
              deleteSlideAction(undo);
            },
            autoClose: false,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (context) {},
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
    )
    );
  }

  void deleteSlideAction(Task undo) {
    setState(() {
      widget.taskList.tasks.remove(undo);
    });
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        action: SnackBarAction(label: 'UNDO', onPressed: () {
          scaffold.hideCurrentSnackBar;
          addTask(undo);
        }),
      ),
    );
  }

  void addTask(Task task) {
    setState(() {
      widget.taskList.tasks.add(task);
      // widget.taskList.sortTasksInDate();
    });
  }

}
