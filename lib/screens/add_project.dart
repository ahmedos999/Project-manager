
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanger/models/data.dart';
import 'package:projectmanger/models/projects.dart';
import 'package:projectmanger/models/tasks.dart';
import 'package:projectmanger/models/users.dart';
import 'package:projectmanger/services/notification_services.dart';
import 'package:projectmanger/services/project_services.dart';
import 'package:projectmanger/services/task_services.dart';
import 'package:projectmanger/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:projectmanger/models/notification.dart';

class addProject extends StatefulWidget {
  const addProject({ Key? key }) : super(key: key);

  @override
  _addProjectState createState() => _addProjectState();
}

class _addProjectState extends State<addProject> {
  List<User> _alluser = [];
  userServices services = userServices();
  DateTime now = DateTime.now();
  
  getAllUsers()async{
    

    var users = await services.readUser();
    users.forEach((user){
      setState(() {
        var model = User();
        model.id = user['id'];
        model.name = user['name'];
        model.email = user['email'];
        model.password = user['password'];
        _alluser.add(model);
      });
    });
  }
  
  var projectNameText = TextEditingController();
  var taskNameText = TextEditingController();

      Project newproject = Project();
      Task newtask = Task();
      Notfications newnotfications = Notfications();


    Random random =  Random();
    projectServices proservices = projectServices();
    final taskServices _taskservices = taskServices();
    final notificationServices _notificationServices = notificationServices();


  @override
void initState() {
    // TODO: implement initState
    super.initState();
   getAllUsers();
  }
  final _formKey = GlobalKey<FormState>();
  final _popKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Container(
                   decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(80),
             bottomLeft: Radius.circular(80),
              ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.25,
                 ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.75,
                  decoration: const BoxDecoration(
            color: Colors.white,
            
                  ),
                  child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Text('Add Project details here ',
                style:GoogleFonts.balsamiqSans(
                  fontSize: 22,
                  color:Colors.black,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 10,),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                  controller: projectNameText,
                  decoration:const InputDecoration(
                    labelText:"Project name",
                    
                    labelStyle: TextStyle(color: Colors.black,fontSize: 16),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder:UnderlineInputBorder(
                        borderSide:BorderSide(color: Colors.black)
                    )
                        ),
                 ) ,
                 const SizedBox(height: 16,),
                  Text('Project tasks',
                      style:GoogleFonts.balsamiqSans(
                        fontSize: 18,
                       color: Colors.black,
                       
                                   ),
                                   ),
                 const SizedBox(height: 16,),
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                     child: Consumer<logindata>(
                       builder: (context,data,child) {
                         return ListView.builder(
                              itemCount:Provider.of<logindata>(context, listen: false).projectTasks.length,
                              itemBuilder: (context,index){
                                return Card(
                                  elevation: 5,
                                  child:ListTile(
                                    title: Text(data.projectTasks[index].name,style:GoogleFonts.balsamiqSans()),
                                    trailing: Text(data.projectTasks[index].user,style:GoogleFonts.balsamiqSans()),
                                  ),
                                );
                              }
                              );
                       }
                     ),
                   ),
                      
                 ),
                 const SizedBox(height: 16,),
                 SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.height*0.08,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 16),
                          child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      
                                    ),
                                  primary: const Color(0xffFF2626), // background
                                  onPrimary: Colors.white // foreground
                                ),
                                onPressed: () { 
                                  if (_formKey.currentState!.validate()) {
                                    showAlertDialog(context);
                                  }
                                    
                                  // print(now.day.toString()+'/'+now.month.toString()+'/'+now.year.toString());
                                  
                                  },
                                child:
                                 Text('Add task',
                                  style:GoogleFonts.balsamiqSans(
                                     fontSize: 16,               
                                ),),
                              ),
                        ),
                    ),
               
                 const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 16),
                          child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      
                                    ),
                                  primary: Colors.black, // background
                                  onPrimary: Colors.white // foreground
                                ),
                                onPressed: () async{ 
                                  if (_formKey.currentState!.validate()) {
                                    if(Provider.of<logindata>(context, listen: false).projectTasks.isNotEmpty){
                                   newproject.id = random.nextInt(10000);
                                   newproject.createdBy = Provider.of<logindata>(context, listen: false).currentusername;
                                   newproject.name = projectNameText.text.toLowerCase().trim();
                                   newproject.date = now.day.toString()+'/'+now.month.toString()+'/'+now.year.toString();
          
                                   var res = await proservices.saveProject(newproject);
                                   Provider.of<logindata>(context, listen: false).clear();
                                   Provider.of<logindata>(context, listen: false).getAllUserProjects();
          
                                  print(res);
                                  Provider.of<logindata>(context, listen: false).clearProjectTasks();
                                  Navigator.pop(context);
                                    }else{
                                      Fluttertoast.showToast(
                                    msg: "please add some tasks",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                    }
                                  }
                                  },
                                child:
                                 Text('Add project',
                                  style:GoogleFonts.balsamiqSans(
                                     fontSize: 18,               
                                ),),
                              ),
                        ),
                    ),
              ],
            ),
                  ),
                ),
                  ],),
          ),
      ),
    
    );
    
    
  }
  showAlertDialog(BuildContext context) {  
    
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
        String dropdownvalue = _alluser[0].name;
        List<String> items = [];
        for (var item in _alluser) {
          
            items.add(item.name);
          
        }
  // var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];

      return  AlertDialog(  
    title: Text("Assign User to Task",style:GoogleFonts.balsamiqSans()),  
    content:  StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Form(
          key: _popKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                  controller: taskNameText,
                  decoration:const InputDecoration(
                    labelText:"Task",
                   
                    labelStyle: TextStyle(color: Colors.black,fontSize: 16),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder:UnderlineInputBorder(
                        borderSide:BorderSide(color: Colors.black)
                    )
                        ),
                 ) ,
                 const SizedBox(height: 10,),
              DropdownButton(
                          value: dropdownvalue,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items:items.map((String items) {
                                 return DropdownMenuItem(
                                     value: items,
                                     child: Text(items)
                                 );
                            }
                            ).toList(),
                          onChanged: ( newValue){
                            setState(() {
                              dropdownvalue = newValue.toString();
                            });
                          },
                        ),
            ],
          ),
        );
      }
    ),
    actions: [  
       TextButton(
            child: Text('Assign Task',style:GoogleFonts.balsamiqSans(color: Colors.black),),
            onPressed: () async{
              if (_popKey.currentState!.validate()) {
              newtask.id = random.nextInt(100000);
              newtask.name = taskNameText.text.toLowerCase().trim();
              newtask.projectName = projectNameText.text.toLowerCase().trim();
              newtask.user = dropdownvalue;
              newtask.status = 'unfinished';

              newnotfications.id = random.nextInt(1000000);
              newnotfications.addedby = Provider.of<logindata>(context, listen: false).currentusername;
              newnotfications.projectName = newtask.projectName = projectNameText.text.toLowerCase().trim();
              newnotfications.user = dropdownvalue;

              var res2 = await _notificationServices.savenotification(newnotfications);
              print(res2);
              var res = await _taskservices.saveTask(newtask);
              print(res);

              Provider.of<logindata>(context, listen: false).clearProjectTasks();
              Provider.of<logindata>(context, listen: false).clearUserTasks();
              Provider.of<logindata>(context, listen: false).getthisProjectsTasks(projectNameText.text.toLowerCase().trim());
               Provider.of<logindata>(context, listen: false).getAllUserTasks();
               taskNameText.text='';
              }
            },
          ),
    ],  
  );  ;  
    },  
  );  
}  
  
}