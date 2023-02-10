import 'package:firebase_app/Model/User.dart';

abstract class StatesApp{}
class StateAppInit extends StatesApp{}
class StateAppGetUserError extends StatesApp{}
class StateAppGetUserSuccess  extends StatesApp{
  UserModel user;
  StateAppGetUserSuccess(this.user);
}

class StateAppGetUserLoading extends StatesApp{}
class StateAppChangeBottomNavigationBar extends StatesApp{

}
