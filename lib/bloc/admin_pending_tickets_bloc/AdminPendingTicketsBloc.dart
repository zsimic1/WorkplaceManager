import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_bloc/AdminPendingTicketsEvent.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_bloc/AdminPendingTicketsState.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';
import 'package:rma_projekt/model/entity/PendingTicket.dart';
import 'package:rma_projekt/model/entity/User.dart';
import 'package:rma_projekt/model/enums/ArrivalCollection.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';
import 'package:rma_projekt/model/enums/UserCollection.dart';

class AdminPendingTicketBloc
    extends Bloc<AdminPendingTicketEvent, AdminPendingTicketState> {
  CollectionReference _arrivalTicketsCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.ARRIVAL_TICKETS);
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(FirestoreCollections.USERS);

  @override
  AdminPendingTicketState get initialState => StateAdminPendingTicketOnInit();

  StreamSubscription<QuerySnapshot> _streamSubscription;
  Stream<QuerySnapshot> _stream;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    await _stream?.drain();
    return super.close();
  }

  @override
  Stream<AdminPendingTicketState> mapEventToState(
      AdminPendingTicketEvent event) async* {
    if (event is EventAdminPendingTicketOnInit) {
      yield StateAdminPendingTicketFetchingTickets();

      _stream = _arrivalTicketsCollection
          .where(ArrivalCollection.STATUS,
              isEqualTo: ArrivalStatusType.WAITING_FOR_APPROVAL)
          .orderBy(ArrivalCollection.DATE_CREATED, descending: true)
          .snapshots();
      _streamSubscription = _stream.listen((event) async {
        List<QueryDocumentSnapshot> docs = event.docs;
        List<PendingTicket> _pendingTickets = [];

        for (var element in docs) {
          var _ticket = ArrivalTicket.fromJson(element.data());

          QuerySnapshot querySnapshot = await _usersCollection
              .where(UserCollection.USERNAME, isEqualTo: _ticket.userUsername)
              .get();

          final users = querySnapshot.docs.map((doc) => doc.data()).toList();
          User _user = User.fromJson(users[0]);

          var _pendingTicket =
              PendingTicket(_ticket, _user.getFirstLastNameString());

          _pendingTickets.add(_pendingTicket);
        }

        add(EventAdminPendingTicketFetchedData(_pendingTickets));
      });
    } else if (event is EventAdminPendingTicketFetchedData) {
      yield StateAdminPendingTicketDone(event.tickets);
    }
  }
}
