abstract class DeleteProductStates {}

class DeleteProductInitialState extends DeleteProductStates {}

class DeleteProductLoadingState extends DeleteProductStates {}

class DeleteProductSuccessState extends DeleteProductStates {}

class DeleteProductFailureState extends DeleteProductStates {
  final String msg;

  DeleteProductFailureState({required this.msg});
}

class EditNetworkErrorState extends DeleteProductStates {}
