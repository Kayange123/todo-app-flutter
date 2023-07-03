import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _box = Hive.box('todo');
  final _controller = TextEditingController();

  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_box.get('todoList') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkboxHandle(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value!;
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
      db.updateData();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
  }

  void addTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: () {
              _controller.clear();
              return Navigator.of(context).pop();
            },
            onSave: saveNewTask,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 25, 143, 247),
        appBar: AppBar(
          title: const Text('Todo'),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTodo,
          backgroundColor: Colors.grey[900],
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.todoList[index][0],
              isDone: db.todoList[index][1],
              onChanged: (bool? value) => checkboxHandle(value, index),
              deleteTask: (context) => deleteTask(index),
            );
          },
        ));
  }
}
