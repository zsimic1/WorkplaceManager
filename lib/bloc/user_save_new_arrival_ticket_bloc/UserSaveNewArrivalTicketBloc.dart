import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/user_save_new_arrival_ticket_bloc/UserSaveNewArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/user_save_new_arrival_ticket_bloc/UserSaveNewArrivalTicketState.dart';
import 'package:rma_projekt/model/database/moor_database.dart';
import 'package:rma_projekt/model/enums/ArrivalCollection.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';

class UserSaveNewArrivalTicketBloc
    extends Bloc<UserSaveNewArrivalTicketEvent, UserSaveNewArrivalTicketState> {
  CollectionReference _arrivalTicketsCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.ARRIVAL_TICKETS);

  @override
  UserSaveNewArrivalTicketState get initialState =>
      StateUserSaveNewArrivalTicketOnInit();

  @override
  Stream<UserSaveNewArrivalTicketState> mapEventToState(
      UserSaveNewArrivalTicketEvent event) async* {
    if (event is EventUserSaveNewArrivalTicketOnSave) {
      yield StateUserSaveNewArrivalTicketStartSaving();

      var _credentialsDao = MoorDatabase().credentialsDao;
      var _credentials = await _credentialsDao.getCredentials();

      _arrivalTicketsCollection
          .where(ArrivalCollection.ID, isEqualTo: event.ticketID)
          .where(ArrivalCollection.USER_USERNAME,
              isEqualTo: _credentials.username)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((document) {
          document.reference.update({
            ArrivalCollection.ARRIVE_DAYS: event.arrivalDays,
            ArrivalCollection.STATUS: ArrivalStatusType.WAITING_FOR_APPROVAL
          });
        });
      });
    }
  }
}
