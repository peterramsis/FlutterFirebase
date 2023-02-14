import 'package:firebase_app/Shard/local/CacheHelper.dart';
import 'package:firebase_app/Shard/style/icon_broken.dart';
import 'package:firebase_app/controller/Cubit/App/CubitApp.dart';
import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:firebase_app/views/component/LoginWidget.dart';
import 'package:firebase_app/views/component/RegisterWidget.dart';
import 'package:firebase_app/views/screens/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StatesApp>(
       builder: (context , state){
         var cubit = CubitApp.get(context);
         return  Scaffold(
           appBar: AppBar(
             elevation: 0,
             title: Text(cubit.pages[cubit.currentIndexBottom!]['title']),
             actions: [

               IconButton(onPressed: (){

               }, icon: Icon(IconBroken.Notification)),
               IconButton(onPressed: (){

               }, icon: Icon(IconBroken.Search)),
               IconButton(onPressed: (){
                 CacheHelper.removeData(key: "uid");
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWidget()));
               }, icon: Icon(Icons.logout)),
             ],
           ),
           body: cubit.pages[cubit.currentIndexBottom!]['page'],
           bottomNavigationBar: BottomNavigationBar(
             type: BottomNavigationBarType.fixed,
             currentIndex: cubit.currentIndexBottom!,
             onTap: (index) => cubit.changeCurrentIndexBottom(index),
             items: [
               BottomNavigationBarItem(icon: Icon(IconBroken.Home)  , label: "Home"),
               BottomNavigationBarItem(icon: Icon(IconBroken.Chat)  , label: "Chat"),
               BottomNavigationBarItem(icon: Icon(IconBroken.Arrow___Down_Circle)  , label: "Post"),
               BottomNavigationBarItem(icon: Icon(IconBroken.Setting)  , label: "Setting"),
               BottomNavigationBarItem(icon: Icon(IconBroken.Profile)  , label: "Profile"),
             ],
           ),
         );
       },
      listener: (context , state){
         print(state);

      },
    );
  }
}
