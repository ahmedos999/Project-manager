import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanger/models/data.dart';
import 'package:projectmanger/models/users.dart';
import 'package:projectmanger/services/user_services.dart';
import 'package:provider/provider.dart';

class profilePage extends StatefulWidget {
  const profilePage({ Key? key }) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  userServices services = userServices();
  User thisUser = User();
    getUserdata()async{
      print('here');
    var users = await services.readUserById(Provider.of<logindata>(context, listen: false).currentuserId);
    print('here2');
    users.forEach((user){
      setState(() {       
        thisUser.id = user['id'];
        thisUser.name = user['name'];
        thisUser.email = user['email'];
        thisUser.password = user['password'];
        thisUser.about = user['about'];
      });
    });
    print(thisUser.id);
    print(thisUser.name);
    print(thisUser.email);
    print(thisUser.password);
    print(thisUser.about);

  }
     @override
   void initState() {
    // TODO: implement initState
    super.initState();
   getUserdata();
  }
  @override
  Widget build(BuildContext context) {
    String name = thisUser.name;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
        const Center(
          child: CircleAvatar(backgroundImage: AssetImage('assets/undraw_male_avatar_323b.png'),radius: 100,),
          
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(thickness: 2,),
        ),
        const SizedBox(height: 10,),
        Text('Name: '+thisUser.name,style:GoogleFonts.balsamiqSans(fontSize: 22),),
        const SizedBox(height: 10,),
        Text('Email: '+thisUser.email,style:GoogleFonts.balsamiqSans(fontSize: 22),),
        const SizedBox(height: 10,),
        Text('About: '+thisUser.about,style:GoogleFonts.balsamiqSans(fontSize: 22),),
      ],),
    );
  }
}