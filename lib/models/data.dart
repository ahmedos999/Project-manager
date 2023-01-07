import 'package:flutter/cupertino.dart';
import 'package:projectmanger/models/notification.dart';
import 'package:projectmanger/models/projects.dart';
import 'package:projectmanger/models/tasks.dart';
import 'package:projectmanger/models/users.dart';
import 'package:projectmanger/services/notification_services.dart';
import 'package:projectmanger/services/project_services.dart';
import 'package:projectmanger/services/task_services.dart';
import 'package:projectmanger/services/user_services.dart';
import 'package:provider/provider.dart';

class logindata extends ChangeNotifier{
 late String currentusername;
 late int currentuserId;
 projectServices proservices = projectServices();
 taskServices taskservices = taskServices();
 notificationServices _notificationServices = notificationServices();
 userServices userservices = userServices();

 List<Project> allprojects = [];
 List<Task> projectTasks = [];
 List<Task> thisUserTasks = [];
 List<Notfications> thisUserNotfications = [];
 List<User>allusers= [];

   getAllUsers()async{
    
    var users = await userservices.readUser();
    users.forEach((user){
      
        var model = User();
        model.id = user['id'];
        model.name = user['name'];
        model.email = user['email'];
        model.password = user['password'];
        allusers.add(model);
      });
    notifyListeners();
  }
  adduser(User user){
    allusers.add(user);
    notifyListeners();
  }

addproject(Project project){
  allprojects.add(project);

  notifyListeners();
}

    getAllUserProjects()async{
    

    var projects = await proservices.readProjectByCreator(currentusername);
    projects.forEach((user){
      
        var model = Project();
        model.id = user['id'];
        model.name = user['name'];
        model.createdBy = user['createdBy'];
        model.date = user['date'];
        allprojects.add(model);
      
    });

    notifyListeners();
  }
      getAllUserNotifications()async{
    

    var notifications = await _notificationServices.readNotficationsforUser(currentusername);
    notifications.forEach((notification){
      
        var model = Notfications();
        model.id = notification['id'];
        model.addedby = notification['addedby'];
        model.projectName = notification['projectName'];
        model.user = notification['user'];
        thisUserNotfications.add(model);
      
    });

    notifyListeners();
  }

    getAllUserTasks()async{
    var tasks = await taskservices.readTaskByAssignment(currentusername);
    tasks.forEach((user){
     
        var model = Task();
        model.id = user['id'];
        model.name = user['name'];
        model.projectName = user['projectName'];
        model.user = user['user'];
        model.status = user['status'];
        thisUserTasks.add(model);
             
    });
    notifyListeners();
  }

      getthisProjectsTasks(projectname)async{
    

    var tasks = await taskservices.readTaskByProject(projectname);
    tasks.forEach((user){
      
        var model = Task();
        model.id = user['id'];
        model.name = user['name'];
        model.projectName = user['projectName'];
        model.user = user['user'];
        model.status = user['status'];
        projectTasks.add(model);
      
    });

    notifyListeners();
  }
  changeStatus(index){
    if(thisUserTasks[index].status == 'finished'){
        thisUserTasks[index].status = 'unfinished';
    }
    else{
      thisUserTasks[index].status = 'finished';
    }
    notifyListeners();
  }
  clear(){
    allprojects = [];
  }
  clearProjectTasks(){
    projectTasks = [];
  }
  clearUserTasks(){
    thisUserTasks = [];
  }
  clearNotification(){
    thisUserNotfications = [];
  }
  logout(){
    allprojects = [];
    projectTasks = [];
    thisUserTasks = [];
    thisUserNotfications = [];
  }
  searchProject(String name)async{
    clear();
    await getAllUserProjects();
    List<Project> filteredprojects = [];
    if(name.isNotEmpty){
    for (var item in allprojects) {
      if(item.name.contains(name)){
        filteredprojects.add(item);
      }
    }
    allprojects = filteredprojects;
    notifyListeners();
  }

  }

  searchTask(String name)async{
    clearUserTasks();
    await getAllUserTasks();
    List<Task> filteredTasks = [];
    if(name.isNotEmpty){
    for (var item in thisUserTasks) {
      if(item.name.contains(name)){
        filteredTasks.add(item);
      }
    }
    thisUserTasks = filteredTasks;
    notifyListeners();
  }

  }
}