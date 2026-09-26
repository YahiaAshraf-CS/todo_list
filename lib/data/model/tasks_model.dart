import 'package:hive/hive.dart';
part 'tasks_model.g.dart';

@HiveType(typeId: 1)
class TasksModel extends HiveObject {
  @HiveField(0)
  String taskName;
  @HiveField(1)
  String taskDescription;
  @HiveField(2)
  StatusTask Status;
  @HiveField(3)
  int colorHex;

  TasksModel({
    required this.taskName,
    required this.taskDescription,
    required this.Status,
    required this.colorHex,
  });
}

@HiveType(typeId: 2)
enum StatusTask {
   @HiveField(0)
   done,
    @HiveField(1)
    pending,
     @HiveField(2)
     inProgress 
      
     }
