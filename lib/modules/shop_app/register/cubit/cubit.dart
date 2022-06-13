import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/login_model.dart';
import 'package:todo_app/modules/shop_app/register/cubit/state.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
      (value) {
        loginModel = ShopLoginModel.fromJson(value.data);
        print(loginModel.status);
        emit(ShopRegisterSuccessState(loginModel));
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopRegisterErrorState(error.toString()));
      },
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
