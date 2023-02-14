import 'package:firebase_app/Model/User.dart';

abstract class StatesApp{}
class StateAppInit extends StatesApp{}
class StateAppGetUserError extends StatesApp{}
class StateAppGetUserSuccess  extends StatesApp{
  UserModel user;
  StateAppGetUserSuccess(this.user);
}

class StateAppGetUserLoading extends StatesApp{}
class StateAppChangeBottomNavigationBar extends StatesApp{}
class StateAppProfilePicturePickedSuccess extends StatesApp{}
class StateAppProfilePicturePickedloading extends StatesApp{}
class StateAppProfilePicturePickedError extends StatesApp{}
