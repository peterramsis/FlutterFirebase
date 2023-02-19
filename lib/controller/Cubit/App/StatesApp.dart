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

class StateAppProfilePictureUploadSuccess extends StatesApp{}
class StateAppProfilePictureUploadloading extends StatesApp{}
class StateAppProfilePictureUploadError extends StatesApp{
  final String error;
  StateAppProfilePictureUploadError(this.error);
}

class StateAppProfileUpdateError extends StatesApp{
  final String error;
  StateAppProfileUpdateError(this.error);
}
class StateAppProfileUpdateLoading extends StatesApp{}
class StateAppProfileUpdateSuccess extends StatesApp{}