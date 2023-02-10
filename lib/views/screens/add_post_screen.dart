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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StatesApp>(
      builder: (context,state) {
        return Container();
      },
          listener: (context, state){

          },
    );
  }
}
