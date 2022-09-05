import 'package:e_commerce/models/change_favorites_model.dart';
import 'package:e_commerce/models/login_model.dart';

abstract class ShopeStates{}
class ShopeInitialState extends ShopeStates{}

class ShopeChangeBottomNavState extends ShopeStates{}
class ShopeLoadingHomeState extends ShopeStates{}

class ShopeSuccessHomeState extends ShopeStates{}

class ShopeErrorHomeState extends ShopeStates{}

class ShopeSuccessCategoriesState extends ShopeStates{}

class ShopeErrorCategoriesState extends ShopeStates{}

class ShopeSuccessChangeFavoritesState extends ShopeStates{
  final ChangeFavoritesModel model;

  ShopeSuccessChangeFavoritesState(this.model);
}

class ShopeErrorChangeFavoritesState extends ShopeStates{}

class ShopeChangeFavoritesState extends ShopeStates{}

class ShopeSuccessGetFavoritesState extends ShopeStates{}
class ShopeLoadingGetFavoritesState extends ShopeStates{}
class ShopeErrorGetFavoritesState extends ShopeStates{}

class ShopeSuccessGetUserDataState extends ShopeStates{
  final LoginModel loginModel;

  ShopeSuccessGetUserDataState(this.loginModel);
}
class ShopeLoadingGetUserDataState extends ShopeStates{}
class ShopeErrorGetUserDataState extends ShopeStates{}
