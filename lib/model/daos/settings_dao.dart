import 'package:moor/moor.dart';
import 'package:rma_projekt/model/database/moor_database.dart';
import 'package:rma_projekt/model/entity/databaseTables/Settings.dart';

part 'settings_dao.g.dart';

@UseDao(tables: [Settingss])
class SettingsDao extends DatabaseAccessor<MoorDatabase>
    with _$SettingsDaoMixin {
  static const int DB_ENTRY_INDEX = 0;

  final MoorDatabase db;

  SettingsDao(this.db) : super(db);

  Future<Settings> getSettings() {
    return (select(settingss)
          ..where((tbl) {
            return tbl.id.equals(DB_ENTRY_INDEX);
          }))
        .getSingle();
  }

  Future insertDefaultSettings() {
    return into(settingss).insert(
        Settings(id: DB_ENTRY_INDEX, logged_in: false, remember_me: false));
  }

  Future updateSettings(SettingssCompanion settings){
    return update(settingss).replace(settings);
  }
}
