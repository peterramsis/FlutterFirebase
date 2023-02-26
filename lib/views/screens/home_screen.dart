import 'package:firebase_app/Model/Post.dart';
import 'package:firebase_app/controller/Cubit/App/CubitApp.dart';
import 'package:firebase_app/controller/Cubit/App/StatesApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Shard/style/color.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

   return BlocConsumer<CubitApp, StatesApp>(
       builder: (context , state) {
         return ConditionalBuilder(
           fallback: (context) {
             return  Center(
               child: CircularProgressIndicator(),
             );
           },
           condition: CubitApp.get(context).userModel != null,
           builder:  (context) {
             return SingleChildScrollView(
               child: Column(
                 children: [
                   if(!FirebaseAuth.instance.currentUser!.emailVerified)
                     Container(
                       color: Colors.amber,
                       padding: EdgeInsets.symmetric(
                           horizontal: 10
                       ),
                       child:Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.info_outline),
                           SizedBox(
                             width: 5,
                           ),
                           Expanded(child: Text("Please verify your email")),
                           SizedBox(
                             width: 5,
                           ),
                           TextButton(onPressed: (){
                             FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
                               SnackBar(
                                   backgroundColor:Colors.red,
                                   content: Container(
                                     child: Text("Send Success" , style: TextStyle(
                                         fontSize: 22
                                     ),),
                                   ));
                             }).catchError((err)=>{
                               print(err)
                             });
                           }, child: Text("Send"))
                         ],
                       ),
                     ),


                   Container(
                     width: double.infinity,
                     child: Card(
                       elevation: 10.0,
                       clipBehavior: Clip.antiAliasWithSaveLayer,
                       child: Stack(
                         alignment: AlignmentDirectional.bottomEnd,
                         children: [
                           Image.asset("assets/images/person.jpg" ,height: 180, fit: BoxFit.cover , width: double.infinity,),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("Contact with me" , style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                 color: Colors.white
                             ),),
                           )
                         ],
                       ) ,

                     ),
                   ),
                   ConditionalBuilder(condition: CubitApp.get(context).posts != null && state is! StateAppPostGetLoading && state != StateAppPostLikeLoading, builder: (context){
                     return getAllPost(CubitApp.get(context).posts);
                   }, fallback: (context){
                      return Center(
                        child: CubitApp.get(context).posts.length != null ? CircularProgressIndicator(): ElevatedButton(onPressed: ()=>CubitApp.get(context).getPost() , child: Text("click")),
                      );
                   })


                 ],
               ),
             );
           },

         );
       },
     listener: (context , state){
         print(state);
     },
   );


  }
  Widget getAllPost(List<Post> posts){
    return Container(
      height: MediaQuery.of(context).size.height - 340,
      child: ListView.builder(itemBuilder: (context , index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Container(

              width: double.infinity,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10.0,
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage("${posts[index].image}"),
                            radius: 25.0,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${posts[index].name}", style: Theme.of(context).textTheme.titleMedium,),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.check_circle, color: defaultColor, size: 14,)
                                ],
                              ),
                              Text("${posts[index].dateTime}" , style: Theme.of(context).textTheme.caption!.copyWith(
                                  height: 1.5
                              ),)
                            ],
                          )),
                          IconButton(onPressed: ()=>{}, icon: Icon(Icons.more_horiz_sharp , color: defaultColor,))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 2,
                          color: Colors.grey[300],
                        ),
                      ),
                      Text(
                        "${posts[index].text}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        child: Container(
                          width: double.infinity,
                          child: Wrap(
                            children: [
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: ()=>{},
                                  child: Text("#Social", style: TextStyle(
                                      color: defaultColor
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child:  Image.network("${posts[index].postImage}" ,height: 160, fit: BoxFit.cover , width: double.infinity,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        child: Row(
                          children: [
                            Expanded(child: InkWell(
                              onTap: (){
                                print("check");
                                CubitApp.get(context).likePost(CubitApp.get(context).postsId[index]);
                              },
                              child: Row(children: [
                                Icon(Icons.heart_broken , color: defaultColor,),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("${CubitApp.get(context).postLike[index]}", style: Theme.of(context).textTheme.caption!.copyWith(
                                    color: defaultColor
                                ),),
                              ],),
                            )),
                            Expanded(child: InkWell(
                              onTap: (){

                              CubitApp.get(context).getPost();

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.chat_outlined, color: defaultColor,),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("120 Comments" , style: Theme.of(context).textTheme.caption!.copyWith(
                                      color: defaultColor
                                  ),),


                                ],),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 2,
                          color: Colors.grey[300],
                        ),
                      ),
                      Row(
                        children: [

                          CircleAvatar(
                            backgroundImage: NetworkImage("https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg"),
                            radius: 20.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child:  TextFormField(
                            decoration: InputDecoration(
                              // label: Text("Write a comment"),
                                labelText: "Write a comment"
                            ),
                          )),

                          InkWell(
                            child: Row(children: [
                              Icon(Icons.send , color: defaultColor,),

                            ],),
                          )


                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },itemCount: posts.length,),
    );
  }
}
