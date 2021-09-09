import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object> get props => [];
}

class StateLoginOnInit extends LoginState {}

class StateLoginFetchedDefaults extends LoginState {
  final String username;
  final String password;
  final bool rememberMe;

  StateLoginFetchedDefaults(this.username, this.password, this.rememberMe);

  @override
  List<Object> get props => [this.username, this.password, this.rememberMe];
}

class StateLoginLoggingIn extends LoginState {}

class StateLoginSuccess extends LoginState {
  final String userType;

  StateLoginSuccess(this.userType);

  @override
  List<Object> get props => [userType];
}

class StateLoginFailed extends LoginState {}
