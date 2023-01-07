import 'package:flutter/material.dart';
import 'package:projectmanger/models/data.dart';
import 'package:projectmanger/models/projects.dart';
import 'package:projectmanger/models/tasks.dart';
import 'package:projectmanger/screens/add_project.dart';
import 'package:projectmanger/screens/profile.dart';
import 'package:projectmanger/screens/project_details.dart';
import 'package:projectmanger/services/notification_services.dart';
import 'package:projectmanger/services/project_services.dart';
import 'package:projectmanger/services/task_services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanger/models/notification.dart';

class homePage extends StatefulWidget {
  const homePage({ Key? key }) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  projectServices proservices = projectServices();
  taskServices taskservices = taskServices();
  final notificationServices _notificationServices = notificationServices();
  var search = TextEditingController();
  var searchtask = TextEditingController();

    getAllUsernotification()async{
    var notifications = await _notificationServices.readNotficationsforUser(Provider.of<logindata>(context, listen: false).currentusername);
    notifications.forEach((notification){
      setState(() {
        var model = Notfications();
        model.id = notification['id'];
        model.addedby = notification['addedby'];
        model.projectName = notification['projectName'];
        model.user = notification['user'];
        Provider.of<logindata>(context, listen: false).thisUserNotfications.add(model);
      });        
    });
  }

  getAllUserTasks()async{
    var tasks = await taskservices.readTaskByAssignment(Provider.of<logindata>(context, listen: false).currentusername);
    tasks.forEach((user){
      setState(() {
        var model = Task();
        model.id = user['id'];
        model.name = user['name'];
        model.projectName = user['projectName'];
        model.user = user['user'];
        model.status = user['status'];
        Provider.of<logindata>(context, listen: false).thisUserTasks.add(model);
      });        
    });
  }
  

    getAllUserProjects()async{

    
    var projects = await proservices.readProjectByCreator(Provider.of<logindata>(context, listen: false).currentusername);
    projects.forEach((user){
      setState(() {
        var model = Project();
        model.id = user['id'];
        model.name = user['name'];
        model.createdBy = user['createdBy'];
        model.date = user['date'];
        Provider.of<logindata>(context, listen: false).allprojects.add(model);
      });
    });
  }

    @override
void initState() {
    // TODO: implement initState
   super.initState();
   getAllUserProjects();
   getAllUserTasks();
   getAllUsernotification();
  }

  String _value = "";
  
  @override
  Widget build(BuildContext context) {
    List<Notfications> _list = Provider.of<logindata>(context, listen: false).thisUserNotfications;
    List<Task> _tasklist = Provider.of<logindata>(context, listen: false).thisUserTasks;
    List<Project> _projectlist = Provider.of<logindata>(context, listen: false).allprojects;
    return WillPopScope(
      onWillPop: () async=> false,
      child: MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
            },
            child: Scaffold(
              appBar: AppBar(             
                actions: [
                InkWell(
                  onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context) =>  const profilePage()),);
                  },
                  child: const Icon(Icons.person,color:Color(0xffFF2626),size: 35,)),
                const SizedBox(width: 30,),
                PopupMenuButton(
                  icon: const Icon(Icons.notifications,color:Color(0xffFF2626),size: 35,),
                    color: const Color(0xffFF2626),
                    elevation: 20,
                    enabled: true,
                    onSelected: (value) {
                      setState(() {
                         _value = value.toString();
                      });
                    },
                    itemBuilder:(context) {
                      return _list.map((Notfications choice) {
                        return PopupMenuItem(
                          value: choice.id,
                          child: Text(choice.addedby+' added you to '+ choice.projectName,style: TextStyle(color: Colors.white),),
                        );
                      }).toList();
                    }
                ),
                const SizedBox(width: 30,),
                InkWell(
                  onTap: (){
                    showAlartDialog(context);
                  },
                  child: const Icon(Icons.logout,color:Color(0xffFF2626),size: 35,)),
              ],
                backgroundColor: Colors.black,
                centerTitle: false,
                bottom: const TabBar(
                  indicatorColor: Color(0xffFF2626),
                  tabs: [
                    Tab(text: 'My Projects',),
                    Tab(text: 'My Tasks',),
                  ],
                ),
                title: Text('Home Page',style:GoogleFonts.balsamiqSans()),
              ),
              body:  TabBarView(
                children: [
                  Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Consumer<logindata>(
                            builder: (context,data,child) {
                              return TextField(
                                onChanged: (value) {
                                  data.searchProject(search.text);
                                },
                                controller: search,
                                decoration:const InputDecoration(
                                  labelText:"search...",
                                  suffixIcon: Icon(Icons.search, color: Colors.black,size: 28,),
                                  labelStyle: TextStyle(color: Colors.black,fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                  ),
                                  focusedBorder:OutlineInputBorder(
                                      borderSide:BorderSide(color: Colors.black)
                                  )
                                      ),
                              );
                            }
                          ) ,
                          const SizedBox(height: 20,),
                          Expanded(
                            child: Consumer<logindata>(
                              builder: (context,data,child) {
                                return ListView.builder(
                                  itemCount:data.allprojects.length,
                                  itemBuilder: (context,index){
                                    return InkWell(
                                      onTap: () {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>  projectDetails(project:data.allprojects[index])),);}, 
                                      child: Card(
                                        elevation: 5,
                                        child:ListTile(
                                          title: Text(data.allprojects[index].name,style:GoogleFonts.balsamiqSans()),
                                          subtitle: Text(data.allprojects[index].createdBy,style:GoogleFonts.balsamiqSans()),
                                          trailing: Text(data.allprojects[index].date,style:GoogleFonts.balsamiqSans()),
                                        ),
                                      ),
                                    );
                                  }
                                  );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                          onPressed: () async{
                            FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            Provider.of<logindata>(context, listen: false).clear();
                            await Provider.of<logindata>(context, listen: false).getAllUserProjects();
                            await Provider.of<logindata>(context, listen: false).getAllUserTasks();
                            search.text = '';
                            searchtask.text='';
                             Navigator.push(context,MaterialPageRoute(builder: (context) => const addProject()),);
                          },
                              label:  Text('Add project',style:GoogleFonts.balsamiqSans()),
                              icon: const Icon(Icons.add,color:Color(0xffFF2626),size: 30,),
                              backgroundColor: Colors.black,
                            ),
                    ),
                  Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        
                        children: [
                          Consumer<logindata>(
                              builder: (context,data,child) {
                                return TextField(
                                  onChanged: (value) {
                                    data.searchTask(searchtask.text);
                                  },
                                  controller: searchtask,
                                  decoration:const InputDecoration(
                                    labelText:"search...",
                                    suffixIcon: Icon(Icons.search, color: Colors.black,size: 28,),
                                    labelStyle: TextStyle(color: Colors.black,fontSize: 16),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                        borderSide:BorderSide(color: Colors.black)
                                    )
                                        ),
                                );
                              }
                            ) ,
                            const SizedBox(height: 20,),
                          Expanded(
                            child: Consumer<logindata>(
                               builder: (context,data,child) {
                                 return ListView.builder(
                                      itemCount:Provider.of<logindata>(context, listen: false).thisUserTasks.length,
                                      itemBuilder: (context,index){
                                        return Card(
                                          elevation: 5,
                                          child:CheckboxListTile(
                                            value:data.thisUserTasks[index].status == 'unfinished'?false:true,
                                            onChanged: (value){
                                              
                                              data.changeStatus(index);
                                              
                                             
                                              taskservices.updateTaskStatus(data.thisUserTasks[index]);
                                            },
                                            title: Text(data.thisUserTasks[index].name,style:GoogleFonts.balsamiqSans()),
                                            secondary: Text(data.thisUserTasks[index].projectName,style:GoogleFonts.balsamiqSans(color: Colors.grey)),
                                          )
                                        );
                                      }
                                      );
                                      // title: Text(data.thisUserTasks[index].name),
                                      //       subtitle: Text(data.thisUserTasks[index].projectName),
                               }
                             ),
                          ),
                        ],
                      ),
                    ),
                    
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  showAlartDialog(BuildContext context){
    showDialog(
    context: context,  
    builder: (BuildContext context) { 
    return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want logout'),
        actions: <Widget>[
          TextButton(
            child: const Text('No',style: TextStyle(color: Color(0xffFF2626)),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes',style: TextStyle(color: Color(0xffFF2626)),),
            onPressed: () {
              Provider.of<logindata>(context, listen: false).logout();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      );
    }
    );
  }
}