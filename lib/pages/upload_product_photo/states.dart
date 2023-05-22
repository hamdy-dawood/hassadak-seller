abstract class UploadProductPhotoStates {}

class UploadProductPhotoInitialState extends UploadProductPhotoStates {}

class UploadProductPhotoLoadingState extends UploadProductPhotoStates {}

class UploadProductPhotoSuccessState extends UploadProductPhotoStates {}

class UploadProductChangeImageStates extends UploadProductPhotoStates {}

class CancelProductChangeImageStates extends UploadProductPhotoStates {}

class UploadProductPhotoFailureState extends UploadProductPhotoStates {
  final String msg;

 UploadProductPhotoFailureState({required this.msg});
}

