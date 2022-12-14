import 'package:e_commerce/shared/constants.dart';

import 'package:e_commerce/states/shope_states.dart';
import 'package:e_commerce/models/categories_model.dart';
import 'package:e_commerce/models/home_model.dart';
import 'package:e_commerce/models/login_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/dio_helper.dart';
import '../shared/end_points.dart';
import '../models/change_favorites_model.dart';
import '../models/favorites_model.dart';
import '../view/categories/categories_screen.dart';
import '../view/favorites/favorits_screen.dart';
import '../view/products/products_screen.dart';
import '../view/settings/settings_screen.dart';

class ShopeCubit extends Cubit<ShopeStates> {
  ShopeCubit() : super(ShopeInitialState());
  static ShopeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritsScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopeChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorits = {};
  void getHomeData() {
    emit(ShopeLoadingHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.formJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorits.addAll({element.id: element.in_favorites});
      });
      emit(ShopeSuccessHomeState());
    }).catchError((error) {
      emit(ShopeErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopeSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopeErrorHomeState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorits[productId] = !favorits[productId]!;
    emit(ShopeChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.formJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorits[productId] = !favorits[productId]!;
      } else {
        getFavoritesData();
      }

      emit(ShopeSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorits[productId] = !favorits[productId]!;
      emit(ShopeErrorChangeFavoritesState());
    });
  }

  // get the products in favorites
  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopeLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopeSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopeErrorGetFavoritesState());
    });
  }

  LoginModel? userModel;
  void getUserData() {
    emit(ShopeLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(ShopeSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopeErrorGetUserDataState());
    });
  }
}
