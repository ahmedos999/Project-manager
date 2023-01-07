class Notfications{
  late int id;
  late String user;
  late String projectName;
  late String addedby;


  notficationMap(){
    var mapping = Map<String,dynamic>();
    mapping['id'] = id;
    mapping['user'] = user;
    mapping['projectName'] = projectName;
    mapping['addedby'] = addedby;

    return mapping;
  }
}