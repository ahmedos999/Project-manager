import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanger/models/data.dart';
import 'package:projectmanger/models/users.dart';
import 'package:projectmanger/services/user_services.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'home_Page.dart';

class registerPage extends StatefulWidget {
  const registerPage({ Key? key }) : super(key: key);

  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  @override
    var UsernameText = TextEditingController();
    var EmailText = TextEditingController();
   var PasswordText= TextEditingController();
    User newuser = User();
    Random random =  Random();
   userServices services = userServices();

   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      
      
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Container(
                   color: Colors.white,
                   child: Container(
             decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
               
               bottomLeft: Radius.circular(100),
                ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,
                   ),
                 ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.75,
                  decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
             topRight: Radius.circular(100),
            //  topLeft: Radius.circular(80),
              ),
                  ),
                  child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Register here',
                style: GoogleFonts.balsamiqSans(
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
                  controller: UsernameText,
                  decoration:const InputDecoration(
                    labelText:"Username",
                    suffixIcon: Icon(Icons.person_outlined, color: Colors.black,size: 28,),
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
                 TextFormField(
                   validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                        return 'invalid email';
                      }
                      return null;
                    },
                  controller: EmailText,
                  decoration:const InputDecoration(
                    labelText:"email",
                    suffixIcon: Icon(Icons.email, color: Colors.black,size: 28,),
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
                TextFormField(
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  controller: PasswordText,
                  obscureText: true, 
                  decoration:const InputDecoration(
                    labelText:"Password",
                    suffixIcon: Icon(Icons.lock_open_outlined, color: Colors.black,size: 28,),
                    labelStyle: TextStyle(color: Colors.black,fontSize: 16),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder:UnderlineInputBorder(
                        borderSide:BorderSide(color: Colors.black)
                    )
                        ),
                 ),
                 const SizedBox(height: 16),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child:  Center(
                      child: Text('already have an account ?',
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 18,
                       color: Colors.black,
                       decoration: TextDecoration.underline,
                                   ),
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
                                      newuser.id = random. nextInt(10000);
                                  newuser.name = UsernameText.text.toLowerCase().trim();
                                  newuser.email = EmailText.text;
                                  newuser.password = PasswordText.text;
                                  newuser.about = 'hi i am '+UsernameText.text;
                                  var res = await services.saveUser(newuser);
          
                                     Provider.of<logindata>(context, listen: false).currentuserId = res;
                                    Provider.of<logindata>(context, listen: false).currentusername = UsernameText.text.toLowerCase().trim();
                                    Provider.of<logindata>(context, listen: false).adduser(newuser);
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => const homePage()),);
                                      
                                    }
                                  },
                                  
                                child:
                                 Text('register',
                                  style: GoogleFonts.balsamiqSans(
                                     fontSize: 18,               
                                ),),
                              ),
                        ),
                    )
              ],
            ),
                  ),
                ),
                  ],),
          ),
      ),
    
    );
  }
}