class User{
  late int id;
  late String name;
  late String password;
  late String email;
  late String about;


  userMap(){
    var mapping = Map<String,dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['password'] = password;
    mapping['email'] = email;
    mapping['about'] = about;

    return mapping;
  }
}