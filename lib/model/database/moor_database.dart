import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rma_projekt/model/daos/credentials_dao.dart';
import 'package:rma_projekt/model/daos/settings_dao.dart';
import 'package:rma_projekt/model/entity/databaseTables/Credentials.dart';
import 'package:rma_projekt/model/entity/databaseTables/Settings.dart';

part 'moor_database.g.dart';

///     flutter packages pub run build_runner watch --delete-conflicting-outputs
///

@UseMoor(daos: [SettingsDao, CredentialsDao], tables: [Settingss, Credentialss])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase._()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        )));

  static final MoorDatabase _instance = MoorDatabase._();

  factory MoorDatabase() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;
}
