
import 'package:projectmanger/models/projects.dart';
import 'package:projectmanger/models/notification.dart';
import 'package:projectmanger/backend/repository.dart';

class notificationServices{

late Repository _repository;
 notificationServices(){
   _repository = Repository();
 }
 //create data 
  savenotification(Notfications notfications ) async{
    return await _repository.insertData('Notfications', notfications.notficationMap());
  }
  // read data
  readNotfications()async{
    return await _repository.readData('Notfications');
  }
// reade category by id 
  readProjectById(NotficationsId) async{
    return _repository.readDataById('Notfications',NotficationsId);
  }
//udate category



  readNotficationsforUser(user) async{
    return _repository.readDataByColumnName('Notfications','user',user);
  }
}

