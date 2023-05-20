import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:hassadak_seller/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitialState());

  static AllProductsCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  AllProductsResponse? allProducts;

  Future<void> getAllProducts({required String id}) async {
    emit(AllProductsLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';

      final response =
          await dio.get(UrlsStrings.allProductsUrl, queryParameters: {
        "uploaderId": id,
      });
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allProducts = AllProductsResponse.fromJson(response.data);
        emit(AllProductsSuccessState());
      } else {
        emit(AllProductsFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AllProductsFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(NetworkErrorState());
      } else {
        errorMsg = 'An unexpected error occurred: ${e.message}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(AllProductsFailedState(msg: 'An unknown error occurred: $e'));
    }
  }
}
