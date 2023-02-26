import 'dart:io';

import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:firebase_app/views/component/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/Cubit/App/CubitApp.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen();

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp,StatesApp>(builder: (context, state){

      return WillPopScope(child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> BlocProvider(create: (context) => CubitApp()..getUser()..getAllUsers()..getPost()..changeCurrentIndexBottom(4),child:  DashboardScreen()))
                );
              },
            ),
            title: Text("Edit Profile"),
            centerTitle: true ),
        body: ConditionalBuilder(
          condition: state is! StateAppGetUserLoading && state is ! StateAppProfilePictureUploadloading && CubitApp.get(context).userModel != null,
          builder: (context){

            var userModel = CubitApp.get(context).userModel;
            dynamic? profileImage = CubitApp.get(context).imageProfile;
            dynamic? profileCover = CubitApp.get(context).imageCover;
            String? name = userModel?.name;
            String? bio = userModel?.bio;
            CubitApp.get(context).name.text = name!;
            CubitApp.get(context).bio.text = bio!;

            return Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                height: 150,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10
                                ), child:profileCover != null ? Image.file(profileCover, width: double.infinity,fit: BoxFit.cover,) :  Image.network( "${userModel?.cover}", fit: BoxFit.cover , width: double.infinity)),
                          ),
                          IconButton(onPressed: () =>CubitApp.get(context).getImageCover(), icon: CircleAvatar(
                            child: Icon(Icons.camera),
                          ))

                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          CircleAvatar(
                            radius: 54,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: profileImage != null ? FileImage(profileImage): NetworkImage("${userModel?.image}")  as ImageProvider ,
                              radius: 50,
                            ),
                          ),
                          IconButton(onPressed: (){

                            CubitApp.get(context).getImageProfile();
                            // CubitApp.get(context).updateProfile();
                          }, icon: CircleAvatar(
                            child: Icon(Icons.camera),
                          ))
                        ],
                      ),


                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(CubitApp.get(context).imageProfile != null)
                      ElevatedButton(onPressed: ()=>CubitApp.get(context).uploadProfileImage(), child: Text("Upload picture")),
                    SizedBox(width: 10,),
                    if(CubitApp.get(context).imageCover != null)
                      ElevatedButton(onPressed: ()=>CubitApp.get(context).uploadProfileCover(), child: Text("Upload cover")),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10), child: Form(child: Column(children: [
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
                    controller: CubitApp.get(context).name,
                    validator: (val){
                      if(val!.isEmpty){
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Bio",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 10,
                                color: Colors.white
                            )
                        )
                    ),
                    controller: CubitApp.get(context).bio,
                    validator: (val){
                      if(val!.isEmpty){
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(onPressed:()=> CubitApp.get(context).updateProfile(), child: Text("Update", style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white
                  )))
                ],)),)
              ],
            );
          },
          fallback: (context){
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ), onWillPop: () async{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=> BlocProvider(create: (context) => CubitApp()..getUser()..getPost()..getAllUsers()..changeCurrentIndexBottom(4),child:  DashboardScreen()))
        );
        return true;
      });
    }, listener: (context, state){

       if(state is StateAppGetUserSuccess){
         print(state.user.name);
       }

    });
  }
}
