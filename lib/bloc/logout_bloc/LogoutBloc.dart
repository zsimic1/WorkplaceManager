import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rma_projekt/bloc/logout_bloc/LogoutEvent.dart';
import 'package:rma_projekt/bloc/logout_bloc/LogoutState.dart';
import 'package:rma_projekt/model/database/moor_database.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  @override
  LogoutState get initialState => StateLogoutOnInit();

  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    if (event is EventLogoutOnButtonPress) {
      yield StateLogoutStarted();

      // update db - settings
      var _settingsDao = MoorDatabase().settingsDao;
      var _settingsOld = await _settingsDao.getSettings();
      var _settings = SettingssCompanion(
          id: Value(0),
          logged_in: Value(false),
          remember_me: Value(_settingsOld.remember_me));
      await _settingsDao.updateSettings(_settings);

      yield StateLogoutDone();
    }
  }
}
