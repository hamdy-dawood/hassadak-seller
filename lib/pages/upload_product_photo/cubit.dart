import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak_seller/core/cache_helper.dart';
import 'package:image_picker/image_picker.dart';

import 'states.dart';

class UploadProductPhotoCubit extends Cubit<UploadProductPhotoStates> {
  UploadProductPhotoCubit() : super(UploadProductPhotoInitialState());

  static UploadProductPhotoCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  File? myImage;

  Future<void> uploadPhoto({required String id}) async {
    emit(UploadProductPhotoLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.patch(
          "https://hasadk-backend.cyclic.app/api/v1/products/uploadProductPhoto/$id",
          data: FormData.fromMap({
            "image": myImage != null
                ? MultipartFile.fromFileSync(
                    myImage!.path,
                    filename: myImage!.path.split("/").last,
                  )
                : null,
          }));
      if (response.data["status"] == "success" && response.statusCode == 201) {
        emit(UploadProductPhotoSuccessState());
      } else {
        emit(UploadProductPhotoFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(UploadProductPhotoFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(UploadProductPhotoFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Invalid status code: ${e.response?.data}';
        emit(UploadProductPhotoFailureState(msg: errorMsg));
        print(errorMsg);
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(UploadProductPhotoFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(UploadProductPhotoFailureState(msg: 'An unknown error: $e'));
    }
  }

  chooseMyImage({ImageSource? source}) {
    ImagePicker.platform.getImage(source: source!).then((value) {
      if (value != null) {
        myImage = File(value.path);
        emit(UploadProductChangeImageStates());
      }
    });
  }

  cancelImage() {
    myImage = null;
    emit(CancelProductChangeImageStates());
  }
}
