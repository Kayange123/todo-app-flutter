import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'widgets/home_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('todo');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
