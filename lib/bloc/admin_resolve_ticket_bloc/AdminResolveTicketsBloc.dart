import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/admin_resolve_ticket_bloc/AdminResolveTicketsEvent.dart';
import 'package:rma_projekt/bloc/admin_resolve_ticket_bloc/AdminResolveTicketsState.dart';
import 'package:rma_projekt/model/enums/ArrivalCollection.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';

class AdminResolveTicketBloc
    extends Bloc<AdminResolveTicketEvent, AdminResolveTicketState> {
  CollectionReference _arrivalTicketsCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.ARRIVAL_TICKETS);

  @override
  AdminResolveTicketState get initialState => StateAdminResolveTicketOnInit();

  @override
  Stream<AdminResolveTicketState> mapEventToState(
      AdminResolveTicketEvent event) async* {
    if (event is EventAdminResolveTicketOnAccept) {
      resolveTicket(event.ticketID, event.username, ArrivalStatusType.APPROVED);
    } else if (event is EventAdminResolveTicketOnDecline) {
      resolveTicket(event.ticketID, event.username, ArrivalStatusType.DECLINED);
    }
  }

  void resolveTicket(String ticketID, String username, String status) {
    _arrivalTicketsCollection
        .where(ArrivalCollection.ID, isEqualTo: ticketID)
        .where(ArrivalCollection.USER_USERNAME, isEqualTo: username)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        document.reference.update({ArrivalCollection.STATUS: status});
      });
    });
  }
}
