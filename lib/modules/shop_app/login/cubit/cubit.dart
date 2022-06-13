import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/models/shop_app/login_model.dart';
import 'package:todo_app/modules/shop_app/login/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  void userLogin({
    @required String email,
    @required String password,
  }) {
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        loginModel = ShopLoginModel.fromJson(value.data);
        print(loginModel.status);
        emit(ShopLoginSuccessState(loginModel));
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopLoginErrorState(error.toString()));
      },
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
