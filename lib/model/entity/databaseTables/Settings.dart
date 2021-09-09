import 'package:moor/moor.dart';

class Settingss extends Table {

  IntColumn get id => integer().withDefault(const Constant(0))();

  BoolColumn get logged_in => boolean().withDefault(const Constant(false))();

  BoolColumn get remember_me => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
