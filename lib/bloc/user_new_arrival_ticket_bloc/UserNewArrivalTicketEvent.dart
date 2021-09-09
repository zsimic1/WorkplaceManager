import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';

abstract class UserNewArrivalTicketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventUserNewArrivalTicketOnInit extends UserNewArrivalTicketEvent {}

class EventUserNewArrivalTicketFetchedData extends UserNewArrivalTicketEvent {
  final List<ArrivalTicket> tickets;

  EventUserNewArrivalTicketFetchedData(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class EventUserNewArrivalTicketCheckboxClicked
    extends UserNewArrivalTicketEvent {
  final int index;
  final bool newValue;
  final String ticketID;

  EventUserNewArrivalTicketCheckboxClicked(
      this.index, this.newValue, this.ticketID);

  @override
  List<Object> get props => [this.index, this.newValue, this.ticketID];
}
