

import 'dart:io';

import 'package:firebase_app/Model/User.dart';
import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:firebase_app/views/screens/add_post_screen.dart';
import 'package:firebase_app/views/screens/chat_screen.dart';
import 'package:firebase_app/views/screens/home_screen.dart';
import 'package:firebase_app/views/screens/profile_screen.dart';
import 'package:firebase_app/views/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../Shard/local/CacheHelper.dart';
class CubitApp extends Cubit<StatesApp>
{
   CubitApp() : super(StateAppInit());

  UserModel? userModel;



   static CubitApp get(context)=> BlocProvider.of(context);
  UserModel? user;
  int? currentIndexBottom = 0;
  var  picker = ImagePicker();
  File? imageProfile;
   File? imageCover;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController address = TextEditingController();

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
      "page" :    AddPostScreen(),
      "title" : "Add Post",
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
    emit(StateAppGetUserLoading());
    FirebaseFirestore.instance.collection("users").doc(CacheHelper.getData(key: "uid")).get().then((value){
      Map<String, dynamic>? data = value.data();
      userModel = UserModel.fromJson(data!);
      print("------data${value.data()}");
      emit(StateAppGetUserSuccess(userModel!));

    }).catchError((err)=>{ print(err)});
  }



   Future<void> getImageProfile() async{
     var image = await picker.pickImage(source: ImageSource.gallery);

   if(image  != null){
     imageProfile = File(image.path);
     emit(StateAppProfilePicturePickedSuccess());
   }else{
     emit(StateAppProfilePicturePickedError());
   }


  }

   Future<void> getImageCover() async{
     var image = await picker.pickImage(source: ImageSource.gallery);

     if(image  != null){
       imageCover = File(image.path);
       emit(StateAppProfilePicturePickedSuccess());
     }else{
       emit(StateAppProfilePicturePickedError());
     }


   }

   String? pathImageProfile = "";

   uploadProfileImage() {
     emit(StateAppProfilePictureUploadloading());
      final storage =  FirebaseStorage.instance.ref().child("user/${Uri.file(imageProfile!.path).pathSegments.last}").putFile(imageProfile!).then(((value){
         value.ref.getDownloadURL().then((value) {
           emit(StateAppProfilePictureUploadSuccess());
           pathImageProfile = value;
           print(pathImageProfile);
         }).catchError((err)=> emit(StateAppProfileUpdateError(err.toString())));
      })).catchError((err){
        emit(StateAppProfilePictureUploadError(err.toString()));
      });
   }

   
   updateProfile() async{


     if(imageProfile != null){
       await uploadProfileImage();

      print( pathImageProfile != "" ?  pathImageProfile: userModel?.cover);
     }


     emit(StateAppProfileUpdateLoading());




     print(userModel?.toMap());
     FirebaseFirestore.instance.collection("users").doc(userModel?.uid).update( {
       "name": name.text,
       "phone" : userModel?.phone,
       "bio": bio.text,
       "email": userModel?.email,
       "address" : userModel?.address,
       "cover":  userModel?.cover,
       "image":  pathImageProfile != "" ?  pathImageProfile: userModel?.image,
       "uid" : userModel?.uid
     }).then((value){
       emit(StateAppGetUserSuccess(userModel!));
       getUser();
       print(userModel?.name);
      }).catchError((err){
       print(err);
     });
   }

}