import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/user_old_arrival_ticket_bloc/UserOldArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/user_old_arrival_ticket_bloc/UserOldArrivalTicketState.dart';
import 'package:rma_projekt/model/database/moor_database.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';
import 'package:rma_projekt/model/enums/ArrivalCollection.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';

class UserOldArrivalTicketBloc
    extends Bloc<UserOldArrivalTicketEvent, UserOldArrivalTicketState> {
  CollectionReference _arrivalTicketsCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.ARRIVAL_TICKETS);

  @override
  UserOldArrivalTicketState get initialState =>
      StateUserOldArrivalTicketOnInit();

  List<ArrivalTicket> _allArrivalTickets = [];

  StreamSubscription<QuerySnapshot> _streamSubscription;
  Stream<QuerySnapshot> _stream;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    await _stream?.drain();
    return super.close();
  }

  @override
  Stream<UserOldArrivalTicketState> mapEventToState(
      UserOldArrivalTicketEvent event) async* {
    if (event is EventUserOldArrivalTicketOnInit) {
      yield StateUserOldArrivalTicketFetchingTickets();

      var _credentialsDao = MoorDatabase().credentialsDao;
      var _credentials = await _credentialsDao.getCredentials();

      _stream = _arrivalTicketsCollection
          .where(ArrivalCollection.USER_USERNAME,
              isEqualTo: _credentials.username)
          // .where(ArrivalCollection.STATUS,
          //     isNotEqualTo: ArrivalStatusType.CREATED)
          .orderBy(ArrivalCollection.DATE_CREATED, descending: true)
          // .orderBy(ArrivalCollection.STATUS)
          .snapshots();

      _streamSubscription = _stream.listen((event) {
        print("event = $event");
        List<QueryDocumentSnapshot> docs = event.docs;
        List<ArrivalTicket> _arrivalTickets = [];
        docs.forEach((element) {
          _arrivalTickets.add(ArrivalTicket.fromJson(element.data()));
        });

        _allArrivalTickets.addAll(_arrivalTickets);

        add(EventUserOldArrivalTicketFetchedData(_arrivalTickets));
      });
    } else if (event is EventUserOldArrivalTicketFetchedData) {
      yield StateUserOldArrivalTicketDone(event.tickets);
    }
  }
}
