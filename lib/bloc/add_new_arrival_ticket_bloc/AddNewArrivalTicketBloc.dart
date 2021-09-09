import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/add_new_arrival_ticket_bloc/AddNewArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/add_new_arrival_ticket_bloc/AddNewArrivalTicketState.dart';
import 'package:rma_projekt/model/entity/ArrivalTicket.dart';
import 'package:rma_projekt/model/entity/User.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';
import 'package:rma_projekt/model/enums/UserCollection.dart';
import 'package:rma_projekt/model/enums/UserType.dart';
import 'package:uuid/uuid.dart';

class AddNewArrivalTicketBloc
    extends Bloc<AddNewArrivalTicketEvent, AddNewArrivalTicketState> {
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(FirestoreCollections.USERS);

  CollectionReference _arrivalTicketsCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.ARRIVAL_TICKETS);

  var _counterOfSentRequests = 0;
  var _maxNumOfPeople;

  @override
  AddNewArrivalTicketState get initialState => StateAddNewArrivalTicketOnInit();

  @override
  Stream<AddNewArrivalTicketState> mapEventToState(
      AddNewArrivalTicketEvent event) async* {
    if (event is EventAddNewArrivalTicketOnClick) {
      if (event.maxNumOfPeople.isNaN ||
          event.maxNumOfPeople <= 0 ||
          event.maxNumOfPeople > 10000) {
        yield StateAddNewArrivalTicketFailed();
        return;
      }

      yield StateAddNewArrivalTicketStarted();

      QuerySnapshot querySnapshot = await _usersCollection
          .where(UserCollection.TYPE, isEqualTo: UserType.USER)
          .get();
      final users = querySnapshot.docs.map((doc) => doc.data()).toList();

      _maxNumOfPeople = users.length;
      var _ticketID = Uuid().v4();

      for (var _userMap in users) {
        var _user = User.fromJson(_userMap);
        var _newArrivalTicket = ArrivalTicket(
            _ticketID,
            _user.username,
            ArrivalStatusType.CREATED,
            [false, false, false, false, false],
            DateTime.now(),
            event.maxNumOfPeople);

        _arrivalTicketsCollection
            .doc()
            .set(_newArrivalTicket.toJsonMap())
            .whenComplete(() {
          add(EventAddNewArrivalTicketSuccess());
        }).catchError((e) {
          add(EventAddNewArrivalTicketFailed());
        });
      }
    } else if (event is EventAddNewArrivalTicketSuccess) {
      _counterOfSentRequests++;
      if (_counterOfSentRequests >= _maxNumOfPeople) {
        yield StateAddNewArrivalTicketSuccess();
      }
    } else if (event is EventAddNewArrivalTicketFailed) {
      yield StateAddNewArrivalTicketFailed();
    }
  }
}
