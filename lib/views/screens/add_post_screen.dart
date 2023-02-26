import 'package:firebase_app/Shard/style/color.dart';
import 'package:flutter/material.dart';

import '../../controller/Cubit/App/CubitApp.dart';
import '../../controller/Cubit/App/StatesApp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController text = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StatesApp>(
      builder: (context,state) {
        dynamic? imagePost = CubitApp.get(context).imagePost;
        return  Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("${CubitApp.get(context).userModel?.image}"),
                    radius: 25.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("${CubitApp.get(context).userModel?.name}", style: Theme.of(context).textTheme.titleMedium,),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.check_circle, color: defaultColor, size: 14,)
                        ],
                      ),

                    ],
                  )
                ],
              ),
              Expanded(child:  TextFormField(
                controller: text,
               decoration: InputDecoration(
                   hintText: "What is on your mind",
                 border: InputBorder.none
               ),
             )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: TextButton(onPressed: ()=> CubitApp.get(context).getImagePost(), child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera),
                      Text("Add photo"),
                    ],
                  ))),
                  Expanded(child: TextButton(onPressed: ()=>{}, child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.tag),
                      Text("Add tag")
                    ],
                  )))
                ],),
              if(imagePost != null)
                Container(
                width: MediaQuery.of(context).size.width,

                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height:200,
                      child: Image.file(imagePost! , fit: BoxFit.cover,)
                    ),
                      IconButton(onPressed: ()=>CubitApp.get(context).removeImagePost(), icon: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close, color: Colors.white),
                      )),
                  ],
                ),
              ),
              ElevatedButton(onPressed: ()=>CubitApp.get(context).uploadAndCreatePost(text: text.text, dateTime: DateTime.now().toString()), child: Text("save"))
            ],
          ),
        );
      },
          listener: (context, state){

          },
    );
  }
}
