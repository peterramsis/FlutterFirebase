

import 'dart:io';

import 'package:firebase_app/Model/MessageModel.dart';
import 'package:firebase_app/Model/Post.dart';
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
   File? imagePost;
   Post? postModel;
   List<Post> posts = [];
   List postsId = [];
   List<int> postLike = [];
   List<UserModel> users = [];
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
    if(index == 1){
      print("index 1");
      getAllUsers();
    }
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

   Future<void> getImagePost() async{
     var image = await picker.pickImage(source: ImageSource.gallery);

     if(image  != null){
       imagePost = File(image.path);
       emit(StateAppPostPicturePickedSuccess());
     }else{
       emit(StateAppPostPicturePickedError());
     }


   }

   removeImagePost(){
      imagePost = null;
      emit(StateAppPostPicturePickedSuccess());

   }

   String? pathImageProfile = "";

   uploadProfileImage(){
     emit(StateAppProfilePictureUploadloading());
       FirebaseStorage.instance.ref().child("user/${Uri.file(imageProfile!.path).pathSegments.last}").putFile(imageProfile!).then(((value){
         value.ref.getDownloadURL().then((value) async{
           pathImageProfile = await value;
           print(pathImageProfile);
           emit(StateAppProfilePictureUploadSuccess());
         }).catchError((err)=> emit(StateAppProfileUpdateError(err.toString())));
      })).catchError((err){
        emit(StateAppProfilePictureUploadError(err.toString()));
      });
   }


   uploadAndCreatePost({
     required String text,
     required String dateTime,
}){
    if(imagePost != null){
      emit(StateAppProfilePictureUploadloading());
      FirebaseStorage.instance.ref().child("post/${Uri.file(imagePost!.path).pathSegments.last}").putFile(imagePost!).then(((value){
        value.ref.getDownloadURL().then((value) async{
          createPost(text: text, dateTime: dateTime, image: value);

          emit(StateAppProfilePictureUploadSuccess());
        }).catchError((err)=> emit(StateAppProfileUpdateError(err.toString())));
      })).catchError((err){
        emit(StateAppProfilePictureUploadError(err.toString()));
      });
    }else{
      createPost(text: text, dateTime: dateTime, image: "");
    }
   }


   String? pathImageCover = "";

   uploadProfileCover(){
     emit(StateAppProfilePictureUploadloading());
     FirebaseStorage.instance.ref().child("user/${Uri.file(imageCover!.path).pathSegments.last}").putFile(imageCover!).then(((value){
       value.ref.getDownloadURL().then((value) async{
         pathImageCover = await value;
         print(pathImageCover);
         emit(StateAppProfilePictureUploadSuccess());
       }).catchError((err)=> emit(StateAppProfileUpdateError(err.toString())));
     })).catchError((err){
       emit(StateAppProfilePictureUploadError(err.toString()));
     });
   }


   updateProfile(){

     emit(StateAppProfileUpdateLoading());
     userModel  = UserModel.fromJson(
         {
           "name": name.text,
           "phone" : userModel?.phone,
           "bio": bio.text,
           "email": userModel?.email,
           "address" : userModel?.address,
           "cover":   pathImageCover != "" ?  pathImageCover: userModel?.image,
           "image":   pathImageProfile != "" ?  pathImageProfile: userModel?.image,
           "uid" : userModel?.uid
         }
     );

     print("test here----${ pathImageProfile != "" ?  pathImageProfile: userModel?.image}");

     FirebaseFirestore.instance.collection("users").doc(userModel?.uid).update(userModel!.toMap()).then((value){
       getUser();
       print(userModel?.name);
      }).catchError((err){
       print(err);
     });
   }

   createPost({
     required String text,
     required String dateTime,
     required String image
}) async{
     emit(StatePostCreateLoading());

     postModel = Post(
       uid: userModel?.uid,
       name: userModel?.name,
       text: text,
       dateTime: dateTime,
       image: userModel?.image,
       postImage: image
     );


    await FirebaseFirestore.instance.collection("post").add(postModel!.toMap()).then((value){
       emit(StateAppPostCreateSuccess(postModel!));
     }).catchError((err)=> StateAppPostCreateError());

   }
   
   getPost(){
     emit(StateAppPostGetLoading());
     FirebaseFirestore.instance.collection("post").get().then((value){
       value.docs.forEach((element) {
         element.reference.collection("likes").get().then((value){
           posts.add(Post.fromJson(element.data()));
           postsId.add(element.id);
           postLike.add(value.docs.length);
         });

         emit(StateAppPostGetSuccess(posts , postsId));

       });
     }).catchError((err)=>print(err));
   }
   
   likePost(String postId){
     emit(StateAppPostLikeLoading());
     FirebaseFirestore.instance.collection("post").doc(postId).collection("likes").doc(userModel?.uid).set({
       'like': true
     }).then((value) => emit(StateAppPostLikeSuccess())).catchError((err)=> emit(StateAppPostLikeError()));
   }

   getAllUsers(){
     emit(StateAppGetUsersLoading());
     users = [];
     FirebaseFirestore.instance.collection("users").get().then((value){
       value.docs.forEach((element) {

          if(element.id != userModel!.uid)
            users.add(UserModel.fromJson(element.data()));
            emit(StateAppGetUsersSuccess(users));
       });
     }).catchError((err){
       emit(StateAppGetUsersError(err.toString()));
     });
   }


   void sendMessage({
     required String receiverId,
     required String dataTime,
     required String text,
   }){

     MessageModel model = MessageModel(
       dateTime: dataTime,
       text:  text,
       receiverId: receiverId,
       senderId: userModel!.uid
     );

     FirebaseFirestore.instance.collection("users")
         .doc(userModel?.uid)
         .collection("chats")
         .doc(receiverId).collection("messages").add(model.toMap()).then((value){

       }).catchError((err){

      });

     FirebaseFirestore.instance.collection("users")
         .doc(receiverId)
         .collection("chats")
         .doc(userModel!.uid).collection("messages").add(model.toMap()).then((value){

     }).catchError((err){

     });
   }

}