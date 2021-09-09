import 'package:equatable/equatable.dart';

abstract class AddNewArrivalTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateAddNewArrivalTicketOnInit extends AddNewArrivalTicketState {}

class StateAddNewArrivalTicketStarted extends AddNewArrivalTicketState {}

class StateAddNewArrivalTicketSuccess extends AddNewArrivalTicketState {}

class StateAddNewArrivalTicketFailed extends AddNewArrivalTicketState {}
