import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/PendingTicket.dart';

abstract class AdminPendingTicketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventAdminPendingTicketOnInit extends AdminPendingTicketEvent {}

class EventAdminPendingTicketFetchedData extends AdminPendingTicketEvent {
  final List<PendingTicket> tickets;

  EventAdminPendingTicketFetchedData(this.tickets);

  @override
  List<Object> get props => [tickets];
}

