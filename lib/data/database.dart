import 'package:hive/hive.dart';

class TodoDatabase {
  final _box = Hive.box('todo');
  List todoList = [];

  void createInitialData() {
    todoList = [
      ['create your todo', false],
      ['click on the checkbox to mark as done', false],
      ['slide to the left to delete the todo', false],
      ['click on the add icon to add a new todo', false],
    ];
  }

  void loadData() {
    todoList = _box.get('todoList', defaultValue: []);
  }

  void updateData() {
    _box.put('todoList', todoList);
  }
}
