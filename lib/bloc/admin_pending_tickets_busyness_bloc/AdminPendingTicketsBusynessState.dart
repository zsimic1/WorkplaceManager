import 'package:equatable/equatable.dart';

abstract class AdminPendingTicketBusynessState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateAdminPendingTicketBusynessOnInit
    extends AdminPendingTicketBusynessState {}

class StateAdminPendingTicketBusynessFetchingTickets
    extends AdminPendingTicketBusynessState {}

class StateAdminPendingTicketBusynessDone
    extends AdminPendingTicketBusynessState {
  final List<int> busyness;

  StateAdminPendingTicketBusynessDone(this.busyness);

  @override
  List<Object> get props => [busyness];
}
