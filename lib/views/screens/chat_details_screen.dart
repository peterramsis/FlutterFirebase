import 'package:firebase_app/Model/MessageModel.dart';
import 'package:firebase_app/Model/User.dart';
import 'package:firebase_app/Shard/style/color.dart';
import 'package:firebase_app/controller/Cubit/App/CubitApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/Cubit/App/CubitApp.dart';
import '../../controller/Cubit/App/StatesApp.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen(this.user) : super();

  final UserModel user;
  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
         //BlocConsumer
    return BlocConsumer<CubitApp,StatesApp>(
         builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${widget.user.image}"),
                        radius: 40,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("${widget.user.name}" , style: Theme.of(context).textTheme.subtitle1,)
                  ],
                ),
              ),
              body: Column(
                children: [

                  ConditionalBuilder(
                    builder: (context){
                      return  Expanded(
                        child: ListView.separated(itemBuilder: (context , index){
                             return CubitApp.get(context).messages[index].senderId == CubitApp.get(context).userModel?.uid ? chatSender(CubitApp.get(context).messages[index]) :chatReceiver();
                        }, separatorBuilder: (context , index){
                           return SizedBox(
                             height: 10,
                           );
                        }, itemCount: CubitApp.get(context).messages.length),
                      );
                    },
                    fallback: (context){
                      return CircularProgressIndicator();
                    }, condition: state is! StateAppGetMessagesLoading && CubitApp.get(context).messages != null,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15
                              ),
                              child: TextFormField(
                                controller: text,
                                decoration: InputDecoration(
                                    hintText: "Type here everything........",
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(onPressed: (){
                            print("chat------");
                            String? uid  = widget.user.uid;
                            CubitApp.get(context).sendMessage(receiverId:uid!, dataTime: DateTime.now().toString(), text: text.text);
                          }, child: Icon(Icons.send , color: defaultColor,),)
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: defaultColor,
                              width: 1.0
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    String? uid = widget.user.uid;
                    CubitApp.get(context).getMessage(uid!);
                  }, child: Text("get"))

                ],
              ),
            );
         },
      listener: (context , state){

      },
    );
  }

  Align chatSender(MessageModel message) {
    return Align(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10
                    ),
                    child: Container(

                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10
                      ),
                      child: Text("${message.text}" , style : TextStyle(
                          color: Colors.white
                      ),),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            bottomEnd:Radius.circular(10),

                          )
                      ),
                    ),
                  ),
                  alignment: Alignment.topRight,
                );
  }

  Align chatReceiver() {
    return Align(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10
                    ),
                    child: Container(

                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10
                      ),
                      child: Text("Hello world"),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            bottomEnd:Radius.circular(10),

                          )
                      ),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                );
  }
}
