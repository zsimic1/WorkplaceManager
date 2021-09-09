import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';

abstract class UserOldArrivalTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateUserOldArrivalTicketOnInit extends UserOldArrivalTicketState {}

class StateUserOldArrivalTicketFetchingTickets extends UserOldArrivalTicketState {}

class StateUserOldArrivalTicketDone extends UserOldArrivalTicketState {
  final List<ArrivalTicket> tickets;

  StateUserOldArrivalTicketDone(this.tickets);

  @override
  List<Object> get props => [tickets];
}
