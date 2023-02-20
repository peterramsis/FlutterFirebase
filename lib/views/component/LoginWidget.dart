import 'package:firebase_app/controller/Cubit/App/CubitApp.dart';
import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:firebase_app/controller/Cubit/Auth/CubitAuth.dart';
import 'package:firebase_app/controller/Cubit/Auth/StatesAuth.dart';
import 'package:firebase_app/views/component/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> CubitAuth() , child: BlocConsumer<CubitAuth,StatesAuth>(builder: (context , state){
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Login", style: TextStyle(
                      fontSize: 35
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: CubitAuth.get(context).keyLogin,
                      child: Column(children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 10,
                                      color: Colors.white
                                  )
                              )
                          ),
                          controller: CubitAuth.get(context).email,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 10,
                                      color: Colors.white
                                  )
                              )
                          ),
                          controller: CubitAuth.get(context).password,
                        ),
                      ],)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(onPressed: ()=>{}, child: Text("Forgot password")),
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 25,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(

                      ),
                      onPressed: ()=> CubitAuth.get(context).login(email: CubitAuth.get(context).email.text, password: CubitAuth.get(context).password.text),
                      child: Text("Login" ,style: TextStyle(
                          fontSize: 20
                      ),),
                    ),
                  ),

                  // ElevatedButton(onPressed: () async{
                  //
                  //   try{
                  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "peter1@gmail.com", password: "Prm_1001_@");
                  //
                  //   }on FirebaseAuthException catch(e){
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red ,content: Container(child: Text("${e.message}", style: TextStyle(
                  //         fontSize:20
                  //     ),)) ));
                  //   }
                  //
                  // }, child: Text("create"))

                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context , state){
      if(state is StatesLoginError){
        print(state);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor:Colors.red,
                content: Container(
                  child: Text("${state.message}" , style: TextStyle(
                      fontSize: 22
                  ),),
                )));
      }else if(state is StatesLoginSuccess){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => BlocProvider<CubitApp>(create: (context) => CubitApp()..getUser()) ));
      }

    }));
  }
}
