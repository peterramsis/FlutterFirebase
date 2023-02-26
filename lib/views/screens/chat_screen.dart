import 'package:firebase_app/Model/User.dart';
import 'package:firebase_app/controller/Cubit/App/CubitApp.dart';
import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:firebase_app/views/screens/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitApp,StatesApp>(
        builder: (context, state){
          return ConditionalBuilder(condition: state is! StateAppGetUsersLoading && CubitApp.get(context).users != null, builder: (context){
            return buildContainer(context , CubitApp.get(context).users);
          }, fallback: (context){
             return Center(
               child: CircularProgressIndicator(),
             );
          });
        },
      listener: (context, state){

      },
    );
  }

  Widget buildContainer(BuildContext context , List<UserModel> users) {
    return ListView.separated(itemBuilder: (context, index){
      return InkWell(
        onTap: (){
          dynamic user =  CubitApp.get(context).users[index];
          print("go");
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>CubitApp()..getUser() , child: ChatDetailsScreen(user!), )));
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${users[index].image}"),
                          radius: 40,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("${users[index].name}" , style: Theme.of(context).textTheme.subtitle1,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },itemCount: users.length, separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },);
  }
}
