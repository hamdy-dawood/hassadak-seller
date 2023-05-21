import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:hassadak_seller/core/cache_helper.dart';

import 'states.dart';

class DeleteProductCubit extends Cubit<DeleteProductStates> {
  DeleteProductCubit() : super(DeleteProductInitialState());

  static DeleteProductCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  Future<void> deleteProduct({required String id}) async {
    emit(DeleteProductLoadingState());
    try {
      dio.options.headers['Authorization'] =
      'Bearer ${CacheHelper.getToken()}';
      final response =
      await dio.delete("${UrlsStrings.allProductsUrl}/$id");
      if (response.data["status"] == "success" &&
          response.statusCode == 200) {
        emit(DeleteProductSuccessState());
      } else {
        emit(DeleteProductFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(DeleteProductFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(EditNetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(DeleteProductFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(DeleteProductFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(DeleteProductFailureState(msg: 'An unknown error : $e'));
    }
  }
}
