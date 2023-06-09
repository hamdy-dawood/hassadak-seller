import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:hassadak_seller/core/snack_and_navigate.dart';

import 'controllers.dart';
import 'model.dart';
import 'states.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  final formKey = GlobalKey<FormState>();
  final controllers = AddProductControllers();
  String? selectedCatId;
  CreateProductResp? createProductResp;

  Future<void> addProduct({
    Map<String, dynamic> discount = const {},
    Map<String, dynamic> discountPerc = const {},
  }) async {
    if (formKey.currentState!.validate()) {
      if (selectedCatId == null) {
        showMessage(message: "من فضلك اختر الفئة !");
      } else {
        emit(AddProductLoadingState());
        try {
          dio.options.headers['Authorization'] =
              'Bearer ${CacheHelper.getToken()}';
          final response = await dio.post(UrlsStrings.allProductsUrl, data: {
            "name": controllers.nameController.text,
            "desc": controllers.descController.text,
            "productUrl": "https://mobizil.com/oppo-f3-specs/",
            ...discount,
            ...discountPerc,
            "typeId": "64496b688a88f4233a2b3e9e",
            "categoryId": selectedCatId,
            "price": controllers.priceController.text,
          });
          if (response.data["status"] == "sucess" &&
              response.statusCode == 201) {
            createProductResp = CreateProductResp.fromJson(response.data);
            emit(AddProductSuccessState());
          } else {
            emit(AddProductFailureState(msg: response.data["status"]));
          }
        } on DioError catch (e) {
          String errorMsg;
          if (e.type == DioErrorType.cancel) {
            errorMsg = 'Request was cancelled';
            emit(AddProductFailureState(msg: errorMsg));
          } else if (e.type == DioErrorType.receiveTimeout ||
              e.type == DioErrorType.sendTimeout) {
            errorMsg = 'Connection timed out';
            emit(AddProductFailureState(msg: errorMsg));
          } else if (e.type == DioErrorType.badResponse) {
            errorMsg = 'Invalid status code: ${e.response?.data}';
            emit(AddProductFailureState(msg: errorMsg));
          } else {
            errorMsg = 'An unexpected error : ${e.error}';
            emit(AddProductFailureState(msg: errorMsg));
          }
        } catch (e) {
          emit(AddProductFailureState(msg: 'An unknown error: $e'));
        }
      }
    }
  }

  void clearController() {
    controllers.nameController.clear();
    controllers.imageController.clear();
    controllers.descController.clear();
    controllers.priceController.clear();
    controllers.discountPercController.clear();
  }

  onChangeCat(value) {
    selectedCatId = value;
    emit(ChangeCatState());
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
