

import 'package:firebase_app/Model/User.dart';
import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:firebase_app/views/screens/chat_screen.dart';
import 'package:firebase_app/views/screens/home_screen.dart';
import 'package:firebase_app/views/screens/profile_screen.dart';
import 'package:firebase_app/views/screens/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Shard/local/CacheHelper.dart';
class CubitApp extends Cubit<StatesApp>
{
  CubitApp() : super(StateAppInit());

  UserModel? userModel;

  CubitApp get(context)=> BlocProvider.of(context);
  UserModel? user;
  int? currentIndexBottom = 1;

  List<Map<String,dynamic>> pages = [
    {
      "page" :    HomeScreen(),
      "title" : "Home",
    },
    {
      "page" :    ChatScreen(),
      "title" : "Chat",
    },
    {
      "page" :    SettingsScreen(),
      "title" : "Setting",
    },
    {
      "page" :  ProfileScreen(),
      "title" : "Profile",
    }
  ];

  changeCurrentIndexBottom(int index){
    currentIndexBottom = index;
    emit(StateAppChangeBottomNavigationBar());
  }

  getUser(){
    FirebaseFirestore.instance.collection("users").doc(CacheHelper.getData(key: "uid")).get().then((value){
      Map<String, dynamic>? data = value.data();
      userModel = UserModel.fromJson(data!);
      emit(StateAppGetUserSuccess(userModel!));

    }).catchError((err)=>{ print(err)});
  }




}