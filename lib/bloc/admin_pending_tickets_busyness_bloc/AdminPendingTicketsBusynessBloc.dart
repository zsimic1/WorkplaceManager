import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_busyness_bloc/AdminPendingTicketsBusynessEvent.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_busyness_bloc/AdminPendingTicketsBusynessState.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';
import 'package:rma_projekt/model/enums/ArrivalCollection.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';

class AdminPendingTicketBusynessBloc extends Bloc<
    AdminPendingTicketBusynessEvent, AdminPendingTicketBusynessState> {
  CollectionReference _arrivalTicketsCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.ARRIVAL_TICKETS);

  @override
  AdminPendingTicketBusynessState get initialState =>
      StateAdminPendingTicketBusynessOnInit();

  StreamSubscription<QuerySnapshot> _streamSubscription;
  Stream<QuerySnapshot> _stream;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    await _stream?.drain();
    return super.close();
  }

  @override
  Stream<AdminPendingTicketBusynessState> mapEventToState(
      AdminPendingTicketBusynessEvent event) async* {
    if (event is EventAdminPendingTicketBusynessOnInit) {
      yield StateAdminPendingTicketBusynessFetchingTickets();

      _stream = _arrivalTicketsCollection
          .where(ArrivalCollection.ID, isEqualTo: event.ticketID)
          .where(ArrivalCollection.STATUS,
              isEqualTo: ArrivalStatusType.APPROVED)
          .snapshots();

      _streamSubscription = _stream.listen((event) async {
        List<QueryDocumentSnapshot> docs = event.docs;
        List<int> _busyness = [0, 0, 0, 0, 0];

        for (var element in docs) {
          var _ticket = ArrivalTicket.fromJson(element.data());

          for (var i = 0; i < 5; i++) {
            if (_ticket.arriveDays[i] == true) {
              _busyness[i]++;
            }
          }
        }

        add(EventAdminPendingTicketBusynessFetchedData(_busyness));
      });
    } else if (event is EventAdminPendingTicketBusynessFetchedData) {
      yield StateAdminPendingTicketBusynessDone(event.busyness);
    }
  }
}
