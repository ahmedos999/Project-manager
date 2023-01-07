
import 'package:projectmanger/models/users.dart';
import 'package:projectmanger/backend/repository.dart';

class userServices{

late Repository _repository;
 userServices(){
   _repository = Repository();
 }
 //create data 
  saveUser(User user) async{
    return await _repository.insertData('Users', user.userMap());
  }
  // read data
  readUser()async{
    return await _repository.readData('Users');
  }
// reade category by id 
  readUserById(userId) async{
    return _repository.readDataById('Users',userId);
  }
//udate category
  updateCategory(User user)async {
    return await _repository.updateData('Users',user.userMap());
  }

  deleteCategory(userId) async{
    return await _repository.deleteData('Users',userId);
  }
}