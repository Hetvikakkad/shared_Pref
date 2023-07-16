import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_prefrence/Auth/loginAuth.dart';

class SecHomePage extends StatefulWidget{

  final String emailValue;
  final String passVAlue ;

  SecHomePage({required this.emailValue,required this.passVAlue});

  @override
  State<StatefulWidget> createState() => OutputClass();
}
class OutputClass extends State<SecHomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("secHomePage"),
      ),
      body: Center(
        child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  Text(widget.emailValue,style: TextStyle(fontSize: 25)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.passVAlue,style: TextStyle(fontSize: 25)),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {  
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    }, child: Text("back"),

                  ),
                ],
              ),
        ),
      ),
    );
   }

}
