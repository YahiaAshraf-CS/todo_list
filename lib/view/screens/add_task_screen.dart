import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/core/app_route.dart';
import 'package:todo_list/data/model/tasks_model.dart';
import 'package:todo_list/view/widgets/choose_color_widget.dart';
import 'package:todo_list/view/widgets/text_form_field_widget.dart';

class AddTaskScreen extends StatefulWidget {
  final TasksModel? task;

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var taskTitle = TextEditingController();
  var taskDescription = TextEditingController();
  String selectedStatus = "In Progress";
  int selectedColor = 0xFFC4C4C4;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      taskTitle.text = widget.task!.taskName;
      taskDescription.text = widget.task!.taskDescription;
      selectedColor = widget.task!.colorHex;

      switch (widget.task!.Status) {
        case StatusTask.done:
          selectedStatus = "Done";
          break;
        case StatusTask.pending:
          selectedStatus = "Pending";
          break;
        case StatusTask.inProgress:
          selectedStatus = "In Progress";
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? 'Add Task' : 'Edit Task',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldWiget(
                labelText: "Task Title",
                hintText: "Enter Your Task Title",
                controller: taskTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Your Task Title";
                  }
                  return null;
                },
                maxLines: 1,
              ),
              const SizedBox(height: 25),
              TextFormFieldWiget(
                labelText: "Task Description",
                hintText: "Enter Your Task Description",
                controller: taskDescription,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Your Task Description";
                  }
                  return null;
                },
                maxLines: 4,
              ),
              const SizedBox(height: 25),
              const Text(
                "Task Status",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color.fromARGB(255, 80, 119, 210),
                    width: 1.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedStatus,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromARGB(255, 104, 142, 230),
                      size: 28,
                    ),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    items: const [
                      DropdownMenuItem(
                        value: "In Progress",
                        child: Text(
                          "In Progress",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Pending",
                        child: Text(
                          "Pending",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Done",
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                "Task Color",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              ChooseColorWidget(
                onColorSelected: (color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
              const SizedBox(height: 35),
              MaterialButton(
                onPressed: () async {
                  if (taskTitle.text.trim().isEmpty ||
                      taskDescription.text.trim().isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                            "Please Enter Task Title and Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const AlertDialog(
                        content: Row(
                          children: [
                            CircularProgressIndicator(
                              color: Color(0xff235BDD),
                              backgroundColor: Color.fromARGB(
                                255,
                                152,
                                195,
                                232,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text("Loading..."),
                          ],
                        ),
                      );
                    },
                  );

                  await Future.delayed(const Duration(seconds: 2));

                  var taskBox = Hive.box<TasksModel>('tasks');

                  StatusTask newStatus = selectedStatus == "In Progress"
                      ? StatusTask.inProgress
                      : selectedStatus == "Pending"
                      ? StatusTask.pending
                      : StatusTask.done;

                  try {
                    if (widget.task != null) {
                      widget.task!.taskName = taskTitle.text;
                      widget.task!.taskDescription = taskDescription.text;
                      widget.task!.Status = newStatus;
                      widget.task!.colorHex = selectedColor;

                      await taskBox.put(widget.task!.key, widget.task!);
                    } else {
                      await taskBox.add(
                        TasksModel(
                          taskName: taskTitle.text,
                          taskDescription: taskDescription.text,
                          Status: newStatus,
                          colorHex: selectedColor,
                        ),
                      );
                    }

                    if (context.mounted) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.home,
                        (route) => false,
                      );
                    }
                  } catch (error) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              error.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                minWidth: double.infinity,
                height: 50,
                color: const Color.fromARGB(255, 79, 18, 231),
                padding: const EdgeInsets.all(10),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                mouseCursor: MaterialStateMouseCursor.clickable,
                hoverColor: const Color.fromARGB(255, 33, 24, 155),
                focusColor: const Color.fromARGB(255, 86, 94, 135),
                child: Text(
                  widget.task == null ? "Create Task" : "Update Task",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
