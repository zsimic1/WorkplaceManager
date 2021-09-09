import 'package:equatable/equatable.dart';

abstract class AdminResolveTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateAdminResolveTicketOnInit
    extends AdminResolveTicketState {}


class StateAdminResolveTicketResolved extends AdminResolveTicketState {
}

class StateAdminResolveTicketFailed
    extends AdminResolveTicketState {}
