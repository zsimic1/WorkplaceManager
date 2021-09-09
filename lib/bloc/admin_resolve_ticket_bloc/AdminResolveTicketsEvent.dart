import 'package:equatable/equatable.dart';

abstract class AdminResolveTicketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventAdminResolveTicketOnAccept extends AdminResolveTicketEvent {
  final String ticketID;
  final String username;

  EventAdminResolveTicketOnAccept(this.ticketID, this.username);

  @override
  List<Object> get props => [this.ticketID, this.username];
}

class EventAdminResolveTicketOnDecline extends AdminResolveTicketEvent {
  final String ticketID;
  final String username;

  EventAdminResolveTicketOnDecline(this.ticketID, this.username);

  @override
  List<Object> get props => [this.ticketID, this.username];
}
