import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/user_new_arrival_ticket_bloc/UserNewArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/user_new_arrival_ticket_bloc/UserNewArrivalTicketState.dart';
import 'package:rma_projekt/model/database/moor_database.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';
import 'package:rma_projekt/model/enums/ArrivalCollection.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';

class UserNewArrivalTicketBloc
    extends Bloc<UserNewArrivalTicketEvent, UserNewArrivalTicketState> {
  CollectionReference _arrivalTicketsCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.ARRIVAL_TICKETS);

  @override
  UserNewArrivalTicketState get initialState =>
      StateUserNewArrivalTicketOnInit();

  List<ArrivalTicket> _allArrivalTickets = [];

  StreamSubscription<QuerySnapshot> _streamSubscription;
  Stream<QuerySnapshot> _stream;

  @override
  Future<void> close() async{
    await _streamSubscription?.cancel();
    await _stream?.drain();
    return super.close();
  }

  @override
  Stream<UserNewArrivalTicketState> mapEventToState(
      UserNewArrivalTicketEvent event) async* {
    if (event is EventUserNewArrivalTicketOnInit) {
      yield StateUserNewArrivalTicketFetchingTickets();

      var _credentialsDao = MoorDatabase().credentialsDao;
      var _credentials = await _credentialsDao.getCredentials();

      _stream = _arrivalTicketsCollection
          .where(ArrivalCollection.STATUS, isEqualTo: ArrivalStatusType.CREATED)
          .where(ArrivalCollection.USER_USERNAME,
              isEqualTo: _credentials.username)
          .orderBy(ArrivalCollection.DATE_CREATED, descending: true)
          .snapshots();

      _streamSubscription = _stream.listen((event) {
        _allArrivalTickets.clear();

        List<QueryDocumentSnapshot> docs = event.docs;
        List<ArrivalTicket> _arrivalTickets = [];
        docs.forEach((element) {
          _arrivalTickets.add(ArrivalTicket.fromJson(element.data()));
        });

        _allArrivalTickets.addAll(_arrivalTickets);

        add(EventUserNewArrivalTicketFetchedData(_arrivalTickets));
      });
    } else if (event is EventUserNewArrivalTicketFetchedData) {
      yield StateUserNewArrivalTicketDone(event.tickets);
    } else if (event is EventUserNewArrivalTicketCheckboxClicked) {
      _allArrivalTickets[_allArrivalTickets
              .indexWhere((element) => element.id == event.ticketID)]
          .arriveDays[event.index] = event.newValue;

      add(EventUserNewArrivalTicketFetchedData(_allArrivalTickets));
    }
  }
}
