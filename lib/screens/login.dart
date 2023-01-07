import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanger/models/data.dart';
import 'package:projectmanger/models/users.dart';
import 'package:projectmanger/screens/home_Page.dart';
import 'package:projectmanger/screens/register.dart';
import 'package:projectmanger/services/user_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    List<User> _alluser = [];
    userServices services = userServices();
    

  
  getAllUsers()async{
    
    var users = await services.readUser();
    users.forEach((user){
      setState(() {
        var model = User();
        model.id = user['id'];
        model.name = user['name'];
        model.email = user['email'];
        model.password = user['password'];
        _alluser.add(model);
      });
    });
  }
  var UsernameText = TextEditingController();
   var PasswordText= TextEditingController();

   @override
   void initState() {
    // TODO: implement initState
    super.initState();
   
   Provider.of<logindata>(context, listen: false).getAllUsers();
  }

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
                 Text('Login',
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
                    onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const registerPage()),),
                    child:  Center(
                      child: Text('dont have an account sign up?',
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
                                onPressed: () { 

                                  if (_formKey.currentState!.validate()) {
                                    if(auth(UsernameText.text.toLowerCase().trim(),PasswordText.text.toLowerCase().trim(),Provider.of<logindata>(context, listen: false).allusers)!=0){
                                    Provider.of<logindata>(context, listen: false).currentuserId = auth(UsernameText.text.toLowerCase().trim(),PasswordText.text.toLowerCase().trim(),Provider.of<logindata>(context, listen: false).allusers);
          
                                    Provider.of<logindata>(context, listen: false).currentusername = UsernameText.text.toLowerCase().trim();
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => const homePage()),);
                                    
                                    // Provider.of<logindata>(context, listen: false).currentuserId = UsernameText.text.toLowerCase().trim();
                                  }else{
                                    Fluttertoast.showToast(
                                    msg: "wrong user name or password",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                  }
                                     }
                                  
                                  
                                  },
                                child:
                                 Text('Login',
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

 int auth(String user,String pass,List<User>_alluser){
   int res = 0;
        for (var item in _alluser) {
          if(item.name.toLowerCase().trim() == user){
            if(item.password.toLowerCase().trim()==pass){
              res = item.id;
            }
          }
        }

  return res;
}