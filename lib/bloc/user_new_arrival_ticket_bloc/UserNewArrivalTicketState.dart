import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';

abstract class UserNewArrivalTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateUserNewArrivalTicketOnInit extends UserNewArrivalTicketState {}

class StateUserNewArrivalTicketFetchingTickets extends UserNewArrivalTicketState {}

class StateUserNewArrivalTicketDone extends UserNewArrivalTicketState {
  final List<ArrivalTicket> tickets;

  StateUserNewArrivalTicketDone(this.tickets);

  @override
  List<Object> get props => [tickets];
}
