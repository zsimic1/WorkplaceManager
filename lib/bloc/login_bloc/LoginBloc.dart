import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rma_projekt/bloc/login_bloc/LoginEvent.dart';
import 'package:rma_projekt/bloc/login_bloc/LoginState.dart';
import 'package:rma_projekt/model/database/moor_database.dart';
import 'package:rma_projekt/model/enums/FirestoreCollections.dart';
import 'package:rma_projekt/model/enums/UserCollection.dart';
import 'package:rma_projekt/model/enums/UserType.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => StateLoginOnInit();

  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(FirestoreCollections.USERS);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EventLoginOnInit) {
      // if remember me checked, fill fields uname and pwd
      var _settingsDao = MoorDatabase().settingsDao;
      var _settings = await _settingsDao.getSettings();
      if (_settings.remember_me) {
        var _credentialsDao = MoorDatabase().credentialsDao;
        var _credentials = await _credentialsDao.getCredentials();
        yield StateLoginFetchedDefaults(_credentials.username,
            _credentials.password, _settings.remember_me);
      }
    } else if (event is EventLoginOnLoginPress) {
      yield StateLoginLoggingIn();
      print("In bloc");
      print("username = ${event.username}");
      print("pass = ${event.password}");
      print("rememberMe = ${event.rememberMe}");

      QuerySnapshot querySnapshot = await _usersCollection
          .where(UserCollection.USERNAME, isEqualTo: event.username)
          .where(UserCollection.PASSWORD, isEqualTo: event.password)
          .get();

      final users = querySnapshot.docs.map((doc) => doc.data()).toList();

      print("users = $users");

      // there is no user with that credentials
      if (users.isEmpty) {
        yield StateLoginFailed();
      }

      // there is user, success
      else {
        var _userType = users[0][UserCollection.TYPE];
        if (_userType != UserType.ADMIN && _userType != UserType.USER) {
          yield StateLoginFailed();
        } else {
          // update db - settings
          var _settingsDao = MoorDatabase().settingsDao;
          var _settings = SettingssCompanion(
              id: Value(0),
              logged_in: Value(true),
              remember_me: Value(event.rememberMe));
          await _settingsDao.updateSettings(_settings);

          // update db - credentials
          var _credentialsDao = MoorDatabase().credentialsDao;
          var _credentials = CredentialssCompanion(
              id: Value(0),
              username: Value(event.username),
              password: Value(event.password),
              userType: Value(_userType));

          await _credentialsDao.updateCredentials(_credentials);

          yield StateLoginSuccess(_userType);
        }
      }
    }
  }
}
