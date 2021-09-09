import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/PendingTicket.dart';

abstract class AdminOldArrivalTicketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventAdminOldArrivalTicketOnInit extends AdminOldArrivalTicketEvent {}

class EventAdminOldArrivalTicketFetchedData extends AdminOldArrivalTicketEvent {
  final List<PendingTicket> tickets;

  EventAdminOldArrivalTicketFetchedData(this.tickets);

  @override
  List<Object> get props => [tickets];
}
