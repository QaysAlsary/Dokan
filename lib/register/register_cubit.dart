import 'package:e_commerce/end_points.dart';
import 'package:e_commerce/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dio_helper.dart';


import 'register_state.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialStates());
  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? registerModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(RegisterLoadingStates());
    DioHelper.postData(url: REGISTER, data: {
      'name':name,
      'phone':phone,
      'email': email,
      'password':password,
    }).then((value) {
      print(value.data);
      registerModel=LoginModel.fromJson(value.data);
      print(registerModel!.status);
      emit(RegisterSuccessStates(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorStates(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix= isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityStates());

  }
}