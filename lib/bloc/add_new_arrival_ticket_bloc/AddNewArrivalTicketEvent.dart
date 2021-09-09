import 'package:equatable/equatable.dart';

abstract class AddNewArrivalTicketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventAddNewArrivalTicketOnClick extends AddNewArrivalTicketEvent {
  final int maxNumOfPeople;

  EventAddNewArrivalTicketOnClick(this.maxNumOfPeople);

  @override
  List<Object> get props => [maxNumOfPeople];
}

class EventAddNewArrivalTicketSuccess extends AddNewArrivalTicketEvent {}

class EventAddNewArrivalTicketFailed extends AddNewArrivalTicketEvent {}
