abstract class UploadProductPhotoStates {}

class UploadProductPhotoInitialState extends UploadProductPhotoStates {}

class UploadProductPhotoLoadingState extends UploadProductPhotoStates {}

class UploadProductPhotoSuccessState extends UploadProductPhotoStates {}

class UploadProductChangeImageState extends UploadProductPhotoStates {}

class CancelProductChangeImageState extends UploadProductPhotoStates {}

class NetworkErrorState extends UploadProductPhotoStates {}

class UploadProductPhotoFailureState extends UploadProductPhotoStates {
  final String msg;

  UploadProductPhotoFailureState({required this.msg});
}
