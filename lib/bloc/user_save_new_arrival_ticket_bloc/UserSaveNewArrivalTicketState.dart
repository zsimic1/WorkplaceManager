import 'package:equatable/equatable.dart';

abstract class UserSaveNewArrivalTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateUserSaveNewArrivalTicketOnInit
    extends UserSaveNewArrivalTicketState {}

class StateUserSaveNewArrivalTicketStartSaving
    extends UserSaveNewArrivalTicketState {}

class StateUserSaveNewArrivalTicketSaved extends UserSaveNewArrivalTicketState {
}

class StateUserSaveNewArrivalTicketFailed
    extends UserSaveNewArrivalTicketState {}
