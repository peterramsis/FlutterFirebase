import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:firebase_app/views/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/Cubit/App/CubitApp.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<CubitApp, StatesApp>(

        builder: (context , state) {
          var userModel = CubitApp.get(context).userModel;
          return Container(
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10
                          ), child: Image.network( "${userModel?.cover}", fit: BoxFit.cover , width: double.infinity,),),
                      ),
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${userModel?.image}"),
                          radius: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Text("${userModel?.name}", style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(
                  height: 4,
                ),
                Text("${userModel?.bio}" , style: Theme.of(context).textTheme.caption,),
                SizedBox(
                  height: 4,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text("100" , style: Theme.of(context).textTheme.subtitle1,),
                                  Text("Post" ,style: Theme.of(context).textTheme.caption),
                                ],
                              ),
                              onTap: (){

                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text("100" , style: Theme.of(context).textTheme.subtitle1,),
                                  Text("Post" ,style: Theme.of(context).textTheme.caption),
                                ],
                              ),
                              onTap: (){

                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text("100" , style: Theme.of(context).textTheme.subtitle1,),
                                  Text("Post" ,style: Theme.of(context).textTheme.caption),
                                ],
                              ),
                              onTap: (){

                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text("100" , style: Theme.of(context).textTheme.subtitle1,),
                                  Text("Post" ,style: Theme.of(context).textTheme.caption),
                                ],
                              ),
                              onTap: (){

                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: OutlinedButton(child: Text("Add Photo"),onPressed: ()=>{},)),
                          SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(child: Icon(Icons.edit),onPressed: ()=>{
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return BlocProvider(
                                create:(context)=> CubitApp()..getUser(),
                                child: EditProfileScreen(),
                              );
                            }))
                          })
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      listener: (context , state){

      },
    );
  }
}
