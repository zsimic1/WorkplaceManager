import 'package:moor/moor.dart';

class Credentialss extends Table {

  IntColumn get id => integer().withDefault(const Constant(0))();

  TextColumn get username => text().withDefault(const Constant(""))();

  TextColumn get password => text().withDefault(const Constant(""))();

  TextColumn get userType => text().withDefault(const Constant(""))();


  @override
  Set<Column> get primaryKey => {id};
}
