import 'package:firebase_app/controller/Cubit/Auth/CubitAuth.dart';
import 'package:firebase_app/controller/Cubit/Auth/StatesAuth.dart';
import 'package:firebase_app/views/component/LoginWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<CubitAuth, StatesAuth>(builder: (context, state){
       return SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               Text("Register", style: TextStyle(
                   fontSize: 35
               ),),
               SizedBox(
                 height: 10,
               ),
               Form(
                 key: CubitAuth.get(context).keyRegister,
                   child: Column(children: [
                 TextFormField(
                       decoration: InputDecoration(
                           labelText: "Name",
                           prefixIcon: Icon(Icons.person),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(
                                   width: 10,
                                   color: Colors.white
                               )
                           )
                       ),
                       controller: CubitAuth.get(context).name,
                       validator: (val){
                         if(val!.isEmpty){
                           return "Please enter your name";
                         }
                         return null;
                       },
                     ),
                 SizedBox(
                       height: 10,
                     ),
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
                   validator: (val){
                      if(val!.isEmpty){
                         return "Please enter your email";
                      }
                      return null;
                   },
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 TextFormField(
                       controller: CubitAuth.get(context).phone,
                       decoration: InputDecoration(
                           labelText: "Phone",
                           prefixIcon: Icon(Icons.phone_android_outlined),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(
                                   width: 10,
                                   color: Colors.white
                               )
                           )
                       ),
                       validator: (val){
                         if(val!.isEmpty){
                           return "Please enter your phone";
                         }
                         return null;
                       },
                     ),
                 SizedBox(
                       height: 10,
                     ),
                 TextFormField(
                       controller: CubitAuth.get(context).address,
                       decoration: InputDecoration(
                           labelText: "Address",
                           prefixIcon: Icon(Icons.map_sharp),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(
                                   width: 10,
                                   color: Colors.white
                               )
                           )
                       ),
                       validator: (val){
                         if(val!.isEmpty){
                           return "Please enter your address";
                         }
                         return null;
                       },
                     ),
                 SizedBox(
                       height: 10,
                     ),
                 TextFormField(
                   controller: CubitAuth.get(context).password,
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
                   validator: (val){
                     if(val!.isEmpty){
                       return "Please enter your password";
                     }
                     return null;
                   },
                 ),

               ],)),
               Align(
                 alignment: Alignment.centerLeft,
                 child: TextButton(onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const LoginWidget())), child: Text("Do you have an account")),
               ),
               Container(
                 height: 60,
                 width: MediaQuery.of(context).size.width ,
                 child: ElevatedButton(
                   style: ElevatedButton.styleFrom(

                   ),
                   onPressed: (){
                     CubitAuth.get(context).register();
                   },
                   child: Text("Register" ,style: TextStyle(
                       fontSize: 20
                   ),),
                 ),
               )

             ],
           ),
         ),
       );
    }, listener: (context, state){
      print(state);
       if(state is StatesRegisterError){

         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                 backgroundColor:Colors.red,
                 content: Container(
           child: Text("${state.message}" , style: TextStyle(
             fontSize: 22
           ),),
         )));
       }
       else if(state is StatesRegisterSuccess){
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                 backgroundColor:Colors.green,
                 content: Container(
                   child: Text("Register done" , style: TextStyle(
                       fontSize: 22
                   ),),
                 )));
       }
    });


  }
}
