class Task{
  late int id;
  late String name;
  late String user;
  late String projectName;
  late String status;


  taskMap(){
    var mapping = Map<String,dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['user'] = user;
    mapping['projectName'] = projectName;
    mapping['status'] = status;

    return mapping;
  }
}