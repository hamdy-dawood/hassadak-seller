abstract class EditProductStates {}

class EditProductInitialState extends EditProductStates {}

class EditProductLoadingState extends EditProductStates {}

class EditProductSuccessState extends EditProductStates {}

class EditProductFailureState extends EditProductStates {
  final String msg;

  EditProductFailureState({required this.msg});
}

class EditNetworkErrorState extends EditProductStates {}
