import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/core/app_route.dart';
import 'package:todo_list/data/model/tasks_model.dart';
import 'package:todo_list/data/model/user_model.dart';
import 'package:todo_list/view/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<UserModel> userBox;
  late Box<TasksModel> tasksBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<UserModel>('user');
    tasksBox = Hive.box<TasksModel>('tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<Box<UserModel>>(
                valueListenable: userBox.listenable(),
                builder: (context, box, _) {
                  var user = box.get('userKey');
                  String currentUserName = user != null
                      ? user.fullName
                      : "User";

                  return Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFF3F51B5),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Good Morning 👋",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            currentUserName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none, size: 28),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder<Box<TasksModel>>(
                valueListenable: tasksBox.listenable(),
                builder: (context, box, _) {
                  int totalTasks = box.length;
                  int doneTasks = box.values
                      .where((task) => task.Status == StatusTask.done)
                      .length;
                  int pendingTasks = box.values
                      .where((task) => task.Status == StatusTask.pending)
                      .length;
                  int inProgressTasks = box.values
                      .where((task) => task.Status == StatusTask.inProgress)
                      .length;

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3F51B5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              totalTasks.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Tasks",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              doneTasks.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              inProgressTasks.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "In Progress",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              pendingTasks.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Pending",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                "Today's Tasks",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ValueListenableBuilder<Box<TasksModel>>(
                valueListenable: tasksBox.listenable(),
                builder: (context, box, _) {
                  if (box.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          "No tasks available",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: box.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      var task = box.getAt(index);
                      if (task == null) return const SizedBox.shrink();
                      return _buildDynamicTaskItem(task);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addTask);
        },
        backgroundColor: const Color(0xFFE0E5FF),
        elevation: 0,
        icon: const Icon(Icons.add, color: Color(0xFF3F51B5)),
        label: const Text(
          "Task",
          style: TextStyle(
            color: Color(0xFF3F51B5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicTaskItem(TasksModel task) {
    String statusText;
    void updateStatus(StatusTask newStatus) {
      task.Status = newStatus;
      tasksBox.put(task.key, task);
    }

    void editTask() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AddTaskScreen(task: task)),
      );
    }

    switch (task.Status) {
      case StatusTask.done:
        statusText = "Done";
        break;
      case StatusTask.pending:
        statusText = "Pending";
        break;
      case StatusTask.inProgress:
        statusText = "In Progress";
        break;
      default:
        statusText = "Unknown";
    }

    return InkWell(
      onTap: editTask,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 54,
              decoration: BoxDecoration(
                color: Color(task.colorHex),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    task.taskDescription,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(task.colorHex).withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: Color(task.colorHex),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                tasksBox.delete(task.key);
              },
              child: const Icon(Icons.delete, color: Colors.red, size: 18),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                updateStatus(StatusTask.done);
              },
              child: const Icon(Icons.done, color: Colors.green, size: 18),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                updateStatus(StatusTask.pending);
              },
              child: const Icon(Icons.pause, color: Colors.yellow, size: 18),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                updateStatus(StatusTask.inProgress);
              },
              child: const Icon(Icons.play_arrow, color: Colors.blue, size: 18),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
