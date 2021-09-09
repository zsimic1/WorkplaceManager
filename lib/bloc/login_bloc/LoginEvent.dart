import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventLoginOnInit extends LoginEvent {}

class EventLoginOnLoginPress extends LoginEvent {
  final String username;
  final String password;
  final bool rememberMe;

  EventLoginOnLoginPress(this.username, this.password, this.rememberMe);

  @override
  List<Object> get props => [username, password, rememberMe];
}
