import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'screens/dashboard.dart';



void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const  MyApp({Key? key});

  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:Dashboard()
       home:Login(),
    );
  }
}


// LOGIN

class Login extends StatefulWidget {
  
  const Login({Key? key}) : super(key: key);
  
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  _handleLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }
  final TextEditingController _nameControler=TextEditingController();
  final TextEditingController _passcontorler=TextEditingController();
  String label='';
  String passlabel='';
  bool isCorrect=5==9;
   bool passcorrect=5==9;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color.fromARGB(128, 1, 1, 16),
        body:Center(
          child:Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 TextField(
                  controller: _nameControler,
                  style: TextStyle(color:Colors.yellow),
                  decoration: InputDecoration(
                    label: Text(label,style: TextStyle(color: Colors.red),),/// NAME VALIDATION
                    constraints: BoxConstraints(minWidth: 100,maxWidth: 400,maxHeight: 35),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintText: 'Username',
                    icon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(color: Colors.white),
                    iconColor: Colors.blue
                  ),
                ),
                const SizedBox(height: 15),
                 TextField(
                  style: TextStyle(color:Colors.yellow),
                  controller: _passcontorler,
                  obscureText: true,
                  decoration: InputDecoration(
                    label:Text(passlabel,style: TextStyle(color: Colors.red),) , // PASSWORD VALIDATION
                    hoverColor: Colors.white,
                    constraints: BoxConstraints(minWidth: 100,maxWidth: 400,maxHeight: 35),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintText: 'Password',
                    icon: Icon(Icons.lock),
                    enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(color: Colors.white),
                    iconColor: Colors.blue
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed:(){
                      if(_nameControler.text.isEmpty & _passcontorler.text.isEmpty){
                        setState(() {
                          label='Enter name';
                          passlabel='Enter password';
                        });                        
                      }else if(_nameControler.text!='franc' || _passcontorler.text!='password'){
                        setState(() {
                          label=_nameControler.text!='franc' ? 'Invalid name':'';
                          passlabel=_passcontorler.text!='password' ? 'Invalid password' : '';

                        });
                      }else if(_nameControler.text=='franc' && _passcontorler.text=='password'){
                      _handleLogin(context);
                      }
                      },
                    style:const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xFF333333)),
                      minimumSize: MaterialStatePropertyAll(Size(300,50))),
                     child:const Text('Login'),),
                )
              ],
            ),
          )
        )
      );
    
  }
}






