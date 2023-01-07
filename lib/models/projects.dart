class Project{
  late int id;
  late String name;
  late String createdBy;
  late String date;


  projectMap(){
    var mapping = Map<String,dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['createdBy'] = createdBy;
    mapping['date'] = date;

    return mapping;
  }
}