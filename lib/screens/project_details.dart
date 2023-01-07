

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanger/models/data.dart';
import 'package:projectmanger/models/projects.dart';
import 'package:projectmanger/models/tasks.dart';
import 'package:projectmanger/services/task_services.dart';
import 'package:provider/provider.dart';

class projectDetails extends StatefulWidget {
  
 final Project project;
  const projectDetails({ Key? key ,required this.project,}) : super(key: key);

  @override
  _projectDetailsState createState() => _projectDetailsState();
}

class _projectDetailsState extends State<projectDetails> {
   taskServices taskservices = taskServices();
   final List<Task> _thisProjectTasks = [];

  getAllProjectTasks()async{
    var tasks = await taskservices.readTaskByProject(widget.project.name);
    tasks.forEach((user){
      setState(() {
        var model = Task();
        model.id = user['id'];
        model.name = user['name'];
        model.projectName = user['projectName'];
        model.user = user['user'];
        model.status = user['status'];
        _thisProjectTasks.add(model);
      });        
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
   getAllProjectTasks();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.project.name,style: GoogleFonts.balsamiqSans(fontSize: 22),),
                                Text(widget.project.date,style:GoogleFonts.balsamiqSans(fontSize: 22)),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              widget.project.createdBy,
                              style:GoogleFonts.balsamiqSans(fontSize: 22)
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:_thisProjectTasks.length,
                            itemBuilder: (context,index){
                              return Card(
                                elevation: 5,
                                child:ListTile(
                                  title: Text(_thisProjectTasks[index].name),
                                  subtitle: Text(_thisProjectTasks[index].user),
                                  trailing: Text(_thisProjectTasks[index].status),
                                ),
                              );
                            
                              }
                              ),
                        ),
                        IconButton(onPressed: () {
                          Navigator.pop(context);
                        },
                        icon:Icon(Icons.backpack) ,
                        )
                      ],
                    ),
                  ),
                ),
                
                );
  }
}