
import 'package:projectmanger/models/projects.dart';

import 'package:projectmanger/backend/repository.dart';
import 'package:projectmanger/models/tasks.dart';

class taskServices{

late Repository _repository;
 taskServices(){
   _repository = Repository();
 }
 //create data 
  saveTask(Task task) async{
    return await _repository.insertData('Tasks', task.taskMap());
  }
  // read data
  readTasks()async{
    return await _repository.readData('Tasks');
  }
// reade category by id 
  readTaskById(tasktId) async{
    return _repository.readDataById('Tasks',tasktId);
  }
//udate category
  // updateCategory(Project project)async {
  //   return await _repository.updateData('Tasks',project.projectMap());
  // }

  // deleteCategory(projectId) async{
  //   return await _repository.deleteData('Tasks',projectId);
  // }

  readTaskByAssignment(assignedUser) async{
    return _repository.readDataByColumnName('Tasks','user',assignedUser);
    
  }
  readTaskByProject(project) async{
    return _repository.readDataByColumnName('Tasks','projectName',project);
  }
  updateTaskStatus(Task data)async{
    return _repository.updateData('Tasks', data.taskMap());
  }
}

