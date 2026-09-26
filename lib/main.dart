import 'package:flutter/material.dart';
import 'package:todo_list/data/model/tasks_model.dart';
import 'package:todo_list/data/model/user_model.dart';

import 'core/app_route.dart';
import 'view/screens/login_screen.dart';
import 'view/screens/home_screen.dart';
import 'view/screens/add_task_screen.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TasksModelAdapter());
  Hive.registerAdapter(StatusTaskAdapter());

  await Hive.openBox<UserModel>('user');
  await Hive.openBox<TasksModel>('tasks');
  await Hive.openBox<StatusTask>('status');

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box<UserModel>('user');
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: userBox.get('userKey') != null
          ? AppRoutes.home
          : AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.addTask: (context) => const AddTaskScreen(),
      },
    );
  }
}
