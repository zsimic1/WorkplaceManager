import 'package:moor_flutter/moor_flutter.dart';
import 'package:rma_projekt/model/database/moor_database.dart';
import 'package:rma_projekt/model/entity/databaseTables/Credentials.dart';

part 'credentials_dao.g.dart';

@UseDao(tables: [Credentialss])
class CredentialsDao extends DatabaseAccessor<MoorDatabase>
    with _$CredentialsDaoMixin {
  static const int DB_ENTRY_INDEX = 0;

  final MoorDatabase db;

  CredentialsDao(this.db) : super(db);

  Future<Credentials> getCredentials() {
    return (select(credentialss)
          ..where((tbl) {
            return tbl.id.equals(DB_ENTRY_INDEX);
          }))
        .getSingle();
  }

  Future insertDefaultCredentials() {
    return into(credentialss).insert(Credentials(
        id: DB_ENTRY_INDEX, username: "", password: "", userType: ""));
  }

  Future updateCredentials(CredentialssCompanion credentials) {
    return update(credentialss).replace(credentials);
  }
}
