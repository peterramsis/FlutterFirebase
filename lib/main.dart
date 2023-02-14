import 'package:firebase_app/Shard/local/CacheHelper.dart';
import 'package:firebase_app/Shard/style/them.dart';
import 'package:firebase_app/controller/Cubit/App/CubitApp.dart';
import 'package:firebase_app/controller/Cubit/Auth/CubitAuth.dart';
import 'package:firebase_app/views/component/DashboardScreen.dart';
import 'package:firebase_app/views/component/LoginWidget.dart';
import 'package:firebase_app/views/component/RegisterWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;

  var uid = await CacheHelper.getData(key: "uid");

  print("---- ${uid}");

  if( uid != null){
    widget =  DashboardScreen();
  }else{
    widget = RegisterWidget();
  }

  print(widget);

  runApp(MyApp(
    widget: widget,
  ));


}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp({required this.widget}) : super();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: ( BuildContext  context) =>  CubitAuth()),
              BlocProvider(create: (BuildContext  context) => CubitApp()..getUser())
            ],
            child:  widget,
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
