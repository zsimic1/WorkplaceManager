import 'package:equatable/equatable.dart';

abstract class UserSaveNewArrivalTicketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventUserSaveNewArrivalTicketOnSave
    extends UserSaveNewArrivalTicketEvent {
  final String ticketID;
  final List<bool> arrivalDays;

  EventUserSaveNewArrivalTicketOnSave(this.ticketID, this.arrivalDays);

  @override
  List<Object> get props => [this.ticketID, this.arrivalDays];
}
