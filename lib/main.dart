import 'package:flutter/material.dart';

import 'core/app_route.dart';
import 'view/screens/login_screen.dart';
import 'view/screens/home_screen.dart';
import 'view/screens/add_task_screen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.addTask: (context) => const AddTaskScreen(),
      },
    );
  }
}
