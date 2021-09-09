import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/add_new_user/AddNewUserEvent.dart';
import 'package:rma_projekt/bloc/add_new_user/AddNewUserState.dart';
import 'package:rma_projekt/model/entity/User.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';
import 'package:rma_projekt/model/enums/UserCollection.dart';
import 'package:rma_projekt/model/enums/UserType.dart';

class AddNewUserBloc extends Bloc<AddNewUserEvent, AddNewUserState> {
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(FirestoreCollections.USERS);

  @override
  AddNewUserState get initialState => StateAddNewUserOnInit();

  @override
  Stream<AddNewUserState> mapEventToState(AddNewUserEvent event) async* {
    if (event is EventAddNewUserOnClick) {
      if (event.firstName.trim().isEmpty ||
          event.lastName.trim().isEmpty ||
          event.username.trim().isEmpty ||
          event.password.trim().isEmpty) {
        yield StateAddNewUserFailedFillAllInputs();
        return;
      }

      yield StateAddNewUserStarted();
      var _user = User(event.firstName.trim(), event.lastName.trim(),
          event.username.trim(), event.password.trim(), UserType.USER);

      QuerySnapshot querySnapshot = await _usersCollection
          .where(UserCollection.USERNAME, isEqualTo: _user.username)
          .get();

      final users = querySnapshot.docs.map((doc) => doc.data()).toList();

      // there is no user with that credentials
      if (users.isNotEmpty) {
        yield StateAddNewUserFailedUsernameTaken();
        return;
      }

      // add user
      _usersCollection.doc().set(_user.toJsonMap()).whenComplete(() {
        add(EventAddNewUserSuccess());
      }).catchError((e) {
        add(EventAddNewUserFailed());
      });
    } else if (event is EventAddNewUserSuccess) {
      yield StateAddNewUserSuccess();
    } else if (event is EventAddNewUserFailed) {
      yield StateAddNewUserFailed();
    }
  }
}
