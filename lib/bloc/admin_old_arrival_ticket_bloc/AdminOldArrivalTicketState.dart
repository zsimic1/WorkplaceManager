import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/PendingTicket.dart';

abstract class AdminOldArrivalTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateAdminOldArrivalTicketOnInit extends AdminOldArrivalTicketState {}

class StateAdminOldArrivalTicketFetchingTickets
    extends AdminOldArrivalTicketState {}

class StateAdminOldArrivalTicketDone extends AdminOldArrivalTicketState {
  final List<PendingTicket> tickets;

  StateAdminOldArrivalTicketDone(this.tickets);

  @override
  List<Object> get props => [tickets];
}
