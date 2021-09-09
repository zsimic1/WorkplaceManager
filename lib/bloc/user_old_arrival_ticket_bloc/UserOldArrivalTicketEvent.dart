import 'package:equatable/equatable.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';

abstract class UserOldArrivalTicketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventUserOldArrivalTicketOnInit extends UserOldArrivalTicketEvent {}

class EventUserOldArrivalTicketFetchedData extends UserOldArrivalTicketEvent {
  final List<ArrivalTicket> tickets;

  EventUserOldArrivalTicketFetchedData(this.tickets);

  @override
  List<Object> get props => [tickets];
}

