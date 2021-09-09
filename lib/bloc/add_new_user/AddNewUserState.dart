import 'package:equatable/equatable.dart';

abstract class AddNewUserState extends Equatable{
  @override
  List<Object> get props => [];
}

class StateAddNewUserOnInit extends AddNewUserState {}

class StateAddNewUserStarted extends AddNewUserState {}

class StateAddNewUserSuccess extends AddNewUserState {}

class StateAddNewUserFailed extends AddNewUserState {}

class StateAddNewUserFailedFillAllInputs extends AddNewUserState {}

class StateAddNewUserFailedUsernameTaken extends AddNewUserState {}
