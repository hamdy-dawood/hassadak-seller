import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/constants/strings.dart';
import 'package:hassadak_seller/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllCategoriesCubit extends Cubit<AllCategoriesStates> {
  AllCategoriesCubit() : super(AllCategoriesInitialStates());

  static AllCategoriesCubit get(context) => BlocProvider.of(context);

  AllCategories? allCategories;
  final dio = Dio();
  int? length;

  Future<void> getAllCategories() async {
    emit(AllCategoriesLoadingStates());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get(UrlsStrings.allCategoriesUrl);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allCategories = AllCategories.fromJson(response.data);
        length = allCategories!.results;
        emit(AllCategoriesSuccessStates(id: allCategories!.data.doc));
      } else {
        emit(AllCategoriesFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AllCategoriesFailedStates(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(AllCategoriesFailedStates(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Invalid status code: ${e.response?.statusCode}';
        emit(AllCategoriesFailedStates(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(AllCategoriesFailedStates(msg: errorMsg));
      }
    } catch (e) {
      emit(AllCategoriesFailedStates(msg: 'An unknown error: $e'));
    }
  }
}
