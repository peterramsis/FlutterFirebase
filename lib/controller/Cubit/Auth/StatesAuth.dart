abstract class StatesAuth{}
class StatesAppInit extends StatesAuth{}

class StatesRegisterError extends StatesAuth{
  String message;
  StatesRegisterError(this.message);
}

class StatesRegisterSuccess extends StatesAuth{}
class StatesRegisterLoading extends StatesAuth{}

class StatesLoginLoading extends StatesAuth{}
class StatesLoginError extends StatesAuth{
  String message;
  StatesLoginError(this.message);
}

class StatesLoginSuccess extends StatesAuth{}