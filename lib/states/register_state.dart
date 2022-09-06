import 'package:e_commerce/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterLoadingStates extends RegisterStates {}

class RegisterSuccessStates extends RegisterStates {
  final LoginModel registerModel;

  RegisterSuccessStates(this.registerModel);
}

class RegisterErrorStates extends RegisterStates {
  final String error;

  RegisterErrorStates(this.error);
}

class ChangeRegisterPasswordVisibilityStates extends RegisterStates {}
