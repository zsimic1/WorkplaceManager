import 'package:equatable/equatable.dart';

abstract class AddNewUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventAddNewUserOnClick extends AddNewUserEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  EventAddNewUserOnClick(
      this.firstName, this.lastName, this.username, this.password);

  @override
  List<Object> get props =>
      [this.firstName, this.lastName, this.username, this.password];
}

class EventAddNewUserSuccess extends AddNewUserEvent {}

class EventAddNewUserFailed extends AddNewUserEvent {}
