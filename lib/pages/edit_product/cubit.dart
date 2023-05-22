import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:hassadak_seller/core/cache_helper.dart';

import 'controller.dart';
import 'states.dart';

class EditProductCubit extends Cubit<EditProductStates> {
  EditProductCubit() : super(EditProductInitialState());

  static EditProductCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final dio = Dio();
  final controllers = EditProductControllers();

  Future<void> editProduct({required String id}) async {
    if (formKey.currentState!.validate()) {
      emit(EditProductLoadingState());
      try {
        dio.options.headers['Authorization'] =
            'Bearer ${CacheHelper.getToken()}';
        final response =
            await dio.patch("${UrlsStrings.allProductsUrl}/$id", data: {
          "name": controllers.nameController.text,
          "desc": controllers.descController.text,
          "productUrl": "https://mobizil.com/oppo-f3-specs/",
          "discount": "Success",
          "discountPerc": controllers.discountPercController.text,
          "typeId": "64496b688a88f4233a2b3e9e",
          "categoryId": "64496b508a88f4233a2b3e97",
          "price": controllers.priceController.text,
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 200) {
          emit(EditProductSuccessState());
        } else {
          emit(EditProductFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(EditProductFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(EditNetworkErrorState());
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
          emit(EditProductFailureState(msg: errorMsg));
        } else {
          errorMsg = 'An unexpected error occurred: ${e.message}';
          emit(EditNetworkErrorState());
        }
      } catch (e) {
        emit(EditProductFailureState(msg: 'An unknown error occurred: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
