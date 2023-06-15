import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:hassadak_seller/core/cache_helper.dart';

import 'controller.dart';
import 'model.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  LoginResponse? loginResponse;
  bool showVisibilityIcon = true;

  final controllers = LoginControllers();

  Future<void> emailLogin() async {
    if (formKey.currentState!.validate()) {
      showVisibilityIcon = false;
      emit(LoginLoadingState());
      try {
        final emailResponse =
            await Dio().post(UrlsStrings.emailLoginUrl, data: {
          "email": controllers.emailController.text,
          "password": controllers.emailPasswordController.text,
        });
        if (emailResponse.data["status"] == "success" &&
            emailResponse.statusCode == 200) {
          loginResponse = LoginResponse.fromJson(emailResponse.data);
          CacheHelper.saveToken("${emailResponse.data["token"]}");
          CacheHelper.saveId("${loginResponse!.data!.user!.id}");
          CacheHelper.saveFirstName("${loginResponse!.data!.user!.firstName}");
          CacheHelper.saveLastName("${loginResponse!.data!.user!.lastName}");
          CacheHelper.saveUserPhoto("${loginResponse!.data!.user!.userPhoto}");
          emit(LoginSuccessState());
          showVisibilityIcon = true;
        } else {
          emit(LoginFailureState(msg: emailResponse.data["status"]));
          showVisibilityIcon = true;
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(LoginFailureState(msg: errorMsg));
          showVisibilityIcon = true;
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(NetworkErrorState(msg: errorMsg));
          showVisibilityIcon = true;
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = '${e.response?.data}';
          emit(LoginFailureState(msg: errorMsg));
          showVisibilityIcon = true;
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(NetworkErrorState(msg: errorMsg));
          showVisibilityIcon = true;
        }
      } catch (e) {
        emit(LoginFailureState(msg: 'An unknown error: $e'));
        showVisibilityIcon = true;
      }
    }
  }

  Future<void> phoneLogin() async {
    if (formKey.currentState!.validate()) {
      showVisibilityIcon = false;
      emit(LoginLoadingState());
      try {
        final phoneResponse =
            await Dio().post(UrlsStrings.phoneLoginUrl, data: {
          "telephone": controllers.phoneController.text,
          "password": controllers.phonePasswordController.text,
        });
        if (phoneResponse.data["status"] == "success" &&
            phoneResponse.statusCode == 200) {
          loginResponse = LoginResponse.fromJson(phoneResponse.data);
          CacheHelper.saveToken("${phoneResponse.data["token"]}");
          CacheHelper.saveId("${loginResponse!.data!.user!.id}");
          emit(LoginSuccessState());
          showVisibilityIcon = true;
        } else {
          emit(LoginFailureState(msg: phoneResponse.data["status"]));
          showVisibilityIcon = true;
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(LoginFailureState(msg: errorMsg));
          showVisibilityIcon = true;
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(NetworkErrorState(msg: errorMsg));
          showVisibilityIcon = true;
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = '${e.response?.data}';
          emit(LoginFailureState(msg: errorMsg));
          showVisibilityIcon = true;
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(NetworkErrorState(msg: errorMsg));
          showVisibilityIcon = true;
        }
      } catch (e) {
        emit(LoginFailureState(msg: 'An unknown error: $e'));
        showVisibilityIcon = true;
      }
    }
  }

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
