import 'package:firebase_app/Model/User.dart';
import 'package:firebase_app/Shard/local/CacheHelper.dart';
import 'package:firebase_app/controller/Cubit/Auth/StatesAuth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CubitAuth extends Cubit<StatesAuth>{
  CubitAuth() : super(StatesAppInit());

  static CubitAuth get(context) => BlocProvider.of(context);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();

  var keyLogin = GlobalKey<FormState>();
  var keyRegister = GlobalKey<FormState>();

  UserModel? user;

  register() async{
    if(keyRegister.currentState!.validate()){
      try{
        emit(StatesRegisterLoading());
         await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value){
          userCreate(
            name: name.text,
            email: email.text,
            phone: phone.text,
            address: address.text,
            uid: value.user!.uid,
            cover: "https://img.freepik.com/free-photo/hesitant-puzzled-unshaven-man-shruggs-shoulders-bewilderment-feels-indecisive-has-bristle-trendy-haircut-dressed-blue-stylish-shirt-isolated-white-wall-clueless-male-poses-indoor_273609-16518.jpg",
            image: "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg",
            bio : "Write here anything"
          );
          emit(StatesRegisterSuccess());
        });
      }on FirebaseAuthException catch(e){
        print("erorr - ${e.message}");
        emit(StatesRegisterError(e.message.toString()));
      }

    }

  }

  userCreate({required String name , required String phone ,required String address ,required String uid , required String email,required String cover , required String image ,required String bio}){
    user = UserModel(name, address, phone,uid, email, cover , image , bio);
    FirebaseFirestore.instance.collection("users").doc(uid).set(user!.toMap()).then((value) => print("done")).catchError((error) =>  emit(StatesRegisterError(error.toString())));
  }


  login({required String email , required String password}) async{
    emit(StatesLoginLoading());
    if(keyLogin.currentState!.validate()){
      try{
        var result =   await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
         CacheHelper.setData(key: "uid", value: result.user?.uid);
         emit(StatesLoginSuccess());
      }on FirebaseAuthException catch(e)
      {
        emit(StatesLoginError(e.message.toString()));
      }

    }

  }

}