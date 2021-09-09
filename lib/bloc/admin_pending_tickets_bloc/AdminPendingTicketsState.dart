import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/PendingTicket.dart';

abstract class AdminPendingTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateAdminPendingTicketOnInit extends AdminPendingTicketState {}

class StateAdminPendingTicketFetchingTickets extends AdminPendingTicketState {}

class StateAdminPendingTicketDone extends AdminPendingTicketState {
  final List<PendingTicket> tickets;

  StateAdminPendingTicketDone(this.tickets);

  @override
  List<Object> get props => [tickets];
}
