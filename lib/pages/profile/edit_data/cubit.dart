import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:hassadak_seller/core/cache_helper.dart';

import 'controller.dart';
import 'states.dart';

class EditDataCubit extends Cubit<EditDataStates> {
  EditDataCubit() : super(EditDataInitialState());

  static EditDataCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final dio = Dio();
  final controllers = EditDataControllers();

  Future<void> getEditData() async {
    if (formKey.currentState!.validate()) {
      emit(EditDataLoadingState());
      try {
        dio.options.headers['Authorization'] =
            'Bearer ${CacheHelper.getToken()}';
        final response = await dio.patch(UrlsStrings.updateUserUrl, data: {
          "firstName": controllers.firstNameController.text,
          "lastName": controllers.lastNameController.text,
          "username": controllers.userNameController.text,
          "telephone": controllers.phoneController.text,
          "image": controllers.imageController.text,
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 200) {
          CacheHelper.saveName(controllers.userNameController.text);
          emit(EditDataSuccessState());
        } else {
          emit(EditDataFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(EditDataFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(EditNetworkErrorState());
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
          emit(EditDataFailureState(msg: errorMsg));
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(EditDataFailureState(msg: errorMsg));
        }
      } catch (e) {
        emit(EditDataFailureState(msg: 'An unknown error : $e'));
      }
    }
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
