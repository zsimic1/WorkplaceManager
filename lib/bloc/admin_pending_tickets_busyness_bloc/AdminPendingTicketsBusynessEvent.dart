import 'package:equatable/equatable.dart';

abstract class AdminPendingTicketBusynessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventAdminPendingTicketBusynessOnInit
    extends AdminPendingTicketBusynessEvent {
  final String ticketID;

  EventAdminPendingTicketBusynessOnInit(this.ticketID);

  @override
  List<Object> get props => [this.ticketID];
}

class EventAdminPendingTicketBusynessFetchedData
    extends AdminPendingTicketBusynessEvent {
  final List<int> busyness;

  EventAdminPendingTicketBusynessFetchedData(this.busyness);

  @override
  List<Object> get props => [busyness];
}
