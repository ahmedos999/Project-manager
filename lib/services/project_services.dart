
import 'package:projectmanger/models/projects.dart';

import 'package:projectmanger/backend/repository.dart';

class projectServices{

late Repository _repository;
 projectServices(){
   _repository = Repository();
 }
 //create data 
  saveProject(Project project) async{
    return await _repository.insertData('Projects', project.projectMap());
  }
  // read data
  readProject()async{
    return await _repository.readData('Projects');
  }
// reade category by id 
  readProjectById(projectId) async{
    return _repository.readDataById('Projects',projectId);
  }
//udate category
  updateCategory(Project project)async {
    return await _repository.updateData('Projects',project.projectMap());
  }

  deleteCategory(projectId) async{
    return await _repository.deleteData('Projects',projectId);
  }
  readProjectByCreator(creator) async{
    return _repository.readDataByColumnName('Projects','createdBy',creator);
  }
}

