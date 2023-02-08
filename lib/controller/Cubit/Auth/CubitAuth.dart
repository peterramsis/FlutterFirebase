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
            uid: value.user!.uid
          );
          emit(StatesRegisterSuccess());
        });
      }on FirebaseAuthException catch(e){
        print("erorr - ${e.message}");
        emit(StatesRegisterError(e.message.toString()));
      }

    }

  }

  userCreate({required String name , required String phone ,required String address ,required String uid , required String email}){
    user = UserModel(name, address, phone,uid, email);
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