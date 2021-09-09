import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable{
  @override
  List<Object> get props => [];
}

class StateLogoutOnInit extends LogoutState {}

class StateLogoutStarted extends LogoutState {}

class StateLogoutDone extends LogoutState {}
