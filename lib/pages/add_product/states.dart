abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class AddProductLoadingState extends AddProductStates {}

class AddProductSuccessState extends AddProductStates {}

class ChangeCatState extends AddProductStates {}

class AddProductFailureState extends AddProductStates {
  final String msg;

  AddProductFailureState({required this.msg});
}
