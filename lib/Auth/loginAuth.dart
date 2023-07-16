
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_prefrence/Auth/secHomepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => LoginPage_State();
}

class LoginPage_State extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  
  bool errorEmail = false;
  bool errorPass = false;
  bool passVisible = false;

  static const String KEYEMAIL = "emailShared";
  static const String KEYPASS = "passShared";

  var emailValue = " ";
  var passValue = "  ";


  @override
  void initState() {
    email.text = "";
    pass.text = "";
    super.initState();
    passVisible = true;

    getvalue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(fontSize: 30,height: 5)),
              SizedBox(height: 48),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter Email Address",
                  errorText: errorEmail?"Enter currect email address":null,
                  filled: false,
                  suffixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: pass,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  errorText: errorPass?"Enter correct passWord":null,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(passVisible? Icons.visibility : Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        passVisible = !passVisible;
                      });
                    },
                  ),
                ),
                obscureText: passVisible,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              Text(emailValue),
              Text(passValue),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: ()  async{
                  //phone number regex check

                  if (email.text.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.text)  ) {
                    setState(() {
                      errorEmail  = true;
                    });
                  }
                  //password regex check
                  if(pass.text.isEmpty || !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(pass.text)) {
                    setState(() {
                      errorPass  = true;
                    });
                  }
                  else{
                    //if condition is true then execute the else part
                    //to store another variable
                    var emailShared = email.text.toString();
                    var passShared = pass.text.toString();

                    //sharedprefrence instance
                    var sharedPref = await SharedPreferences.getInstance();

                    //to store a value in string
                    sharedPref.setString(KEYEMAIL,emailShared);
                    sharedPref.setString(KEYPASS, passShared);

                    //setState
                    setState(() {
                      errorEmail = false;
                      errorPass = false;

                      // navigate another page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SecHomePage(emailValue: emailValue ,passVAlue: passValue)),
                      );
                    });
                  }
                },
                child: Text("Login",) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void getvalue() async {
    
    var pref = await SharedPreferences.getInstance();
    var getEmail = pref.getString(LoginPage_State.KEYEMAIL);
    var getPass = pref.getString(LoginPage_State.KEYPASS);

      emailValue = getEmail ?? "no value";
      passValue = getPass ?? "no value";
      setState(() {

      });
  }
}


