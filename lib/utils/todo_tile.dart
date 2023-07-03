// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final bool isDone;
  final String taskName;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;

  const TodoTile({
    super.key,
    required this.isDone,
    required this.taskName,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 20),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
              onPressed: deleteTask,
              label: 'Delete',
              icon: Icons.delete_forever,
              backgroundColor: Colors.red.shade300,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ))
        ]),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                value: isDone,
                onChanged: onChanged,
                activeColor: Colors.black54,
              ),
              Text(taskName,
                  style: TextStyle(
                      decoration: isDone ? TextDecoration.lineThrough : null)),
            ],
          ),
        ),
      ),
    );
  }
}
