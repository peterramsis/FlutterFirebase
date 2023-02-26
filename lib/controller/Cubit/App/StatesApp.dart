import 'package:firebase_app/Model/Post.dart';
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



class StateAppPostPicturePickedSuccess extends StatesApp{}
class StateAppPostPicturePickedloading extends StatesApp{}
class StateAppPostPicturePickedError extends StatesApp{}

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

class StateAppPostCreateError extends StatesApp{}
class StateAppPostCreateSuccess  extends StatesApp{
  Post post;
  StateAppPostCreateSuccess(this.post);
}

class StatePostCreateLoading extends StatesApp{}

class StateAppPostGetError extends StatesApp{}
class StateAppPostGetSuccess extends StatesApp{
  List<Post> post;
  List postsId;
  StateAppPostGetSuccess(this.post , this.postsId);
}
class StateAppPostGetLoading extends StatesApp{}
class StateAppPostLikeSuccess extends StatesApp{}
class StateAppPostLikeLoading extends StatesApp{}
class StateAppPostLikeError extends StatesApp{}


class StateAppGetUsersSuccess extends StatesApp{
  List<UserModel> users;
  StateAppGetUsersSuccess(this.users);
}
class StateAppGetUsersLoading extends StatesApp{}
class StateAppGetUsersError extends StatesApp{
  String error;
  StateAppGetUsersError(this.error);
}
