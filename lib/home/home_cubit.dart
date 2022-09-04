import 'package:e_commerce/categories/categories_screen.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/favorites/favorits_screen.dart';
import 'package:e_commerce/home/home_states.dart';
import 'package:e_commerce/models/categories_model.dart';
import 'package:e_commerce/models/home_model.dart';
import 'package:e_commerce/products/products_screen.dart';
import 'package:e_commerce/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dio_helper.dart';
import '../end_points.dart';
import '../models/change_favorites_model.dart';
import '../models/favorites_model.dart';

class ShopeCubit extends Cubit<ShopeStates>{

  ShopeCubit():super(ShopeInitialState());
  static ShopeCubit get(context) =>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>bottomScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritsScreen(),
    SettingsScreen(),

  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopeChangeBottomNavState());
  }
  HomeModel? homeModel;
  Map<int,bool> favorits={};
  void getHomeData(){
    emit(ShopeLoadingHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {

      homeModel = HomeModel.formJson(value.data) ;
      homeModel!.data!.products.forEach((element) {
        favorits.addAll({
          element.id: element.in_favorites
        });
      });
    emit(ShopeSuccessHomeState());
    }).catchError((error){
      print(error.toString());
      print(homeModel.toString());
      print(token);

      emit(ShopeErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){

    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopeSuccessCategoriesState());
    }).catchError((error){

      emit(ShopeErrorHomeState());
    });
  }

  ChangeFavoritesModel?  changeFavoritesModel;
  void changeFavorites(int productId){
    favorits[productId]= !favorits[productId]!;
    emit(ShopeChangeFavoritesState());
  DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':productId,
      },
    token: token,
  ).then((value)  {
    changeFavoritesModel= ChangeFavoritesModel.formJson(value.data);
    if(!changeFavoritesModel!.status){
      favorits[productId]= !favorits[productId]!;
    }else{
      getFavoritesData();
    }

    emit(ShopeSuccessChangeFavoritesState(changeFavoritesModel!));
  }).catchError((error){
    favorits[productId]= !favorits[productId]!;
    emit(ShopeErrorChangeFavoritesState());
  });
  }
 // get the products in favorites
  FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(ShopeLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopeSuccessGetFavoritesState());
    }).catchError((error){

      emit(ShopeErrorGetFavoritesState());
    });
  }
}