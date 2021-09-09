// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Settings extends DataClass implements Insertable<Settings> {
  final int id;
  final bool logged_in;
  final bool remember_me;
  Settings(
      {@required this.id,
      @required this.logged_in,
      @required this.remember_me});
  factory Settings.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Settings(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      logged_in:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}logged_in']),
      remember_me: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}remember_me']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || logged_in != null) {
      map['logged_in'] = Variable<bool>(logged_in);
    }
    if (!nullToAbsent || remember_me != null) {
      map['remember_me'] = Variable<bool>(remember_me);
    }
    return map;
  }

  SettingssCompanion toCompanion(bool nullToAbsent) {
    return SettingssCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      logged_in: logged_in == null && nullToAbsent
          ? const Value.absent()
          : Value(logged_in),
      remember_me: remember_me == null && nullToAbsent
          ? const Value.absent()
          : Value(remember_me),
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Settings(
      id: serializer.fromJson<int>(json['id']),
      logged_in: serializer.fromJson<bool>(json['logged_in']),
      remember_me: serializer.fromJson<bool>(json['remember_me']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'logged_in': serializer.toJson<bool>(logged_in),
      'remember_me': serializer.toJson<bool>(remember_me),
    };
  }

  Settings copyWith({int id, bool logged_in, bool remember_me}) => Settings(
        id: id ?? this.id,
        logged_in: logged_in ?? this.logged_in,
        remember_me: remember_me ?? this.remember_me,
      );
  @override
  String toString() {
    return (StringBuffer('Settings(')
          ..write('id: $id, ')
          ..write('logged_in: $logged_in, ')
          ..write('remember_me: $remember_me')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(id.hashCode, $mrjc(logged_in.hashCode, remember_me.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Settings &&
          other.id == this.id &&
          other.logged_in == this.logged_in &&
          other.remember_me == this.remember_me);
}

class SettingssCompanion extends UpdateCompanion<Settings> {
  final Value<int> id;
  final Value<bool> logged_in;
  final Value<bool> remember_me;
  const SettingssCompanion({
    this.id = const Value.absent(),
    this.logged_in = const Value.absent(),
    this.remember_me = const Value.absent(),
  });
  SettingssCompanion.insert({
    this.id = const Value.absent(),
    this.logged_in = const Value.absent(),
    this.remember_me = const Value.absent(),
  });
  static Insertable<Settings> custom({
    Expression<int> id,
    Expression<bool> logged_in,
    Expression<bool> remember_me,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logged_in != null) 'logged_in': logged_in,
      if (remember_me != null) 'remember_me': remember_me,
    });
  }

  SettingssCompanion copyWith(
      {Value<int> id, Value<bool> logged_in, Value<bool> remember_me}) {
    return SettingssCompanion(
      id: id ?? this.id,
      logged_in: logged_in ?? this.logged_in,
      remember_me: remember_me ?? this.remember_me,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logged_in.present) {
      map['logged_in'] = Variable<bool>(logged_in.value);
    }
    if (remember_me.present) {
      map['remember_me'] = Variable<bool>(remember_me.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingssCompanion(')
          ..write('id: $id, ')
          ..write('logged_in: $logged_in, ')
          ..write('remember_me: $remember_me')
          ..write(')'))
        .toString();
  }
}

class $SettingssTable extends Settingss
    with TableInfo<$SettingssTable, Settings> {
  final GeneratedDatabase _db;
  final String _alias;
  $SettingssTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _logged_inMeta = const VerificationMeta('logged_in');
  GeneratedBoolColumn _logged_in;
  @override
  GeneratedBoolColumn get logged_in => _logged_in ??= _constructLoggedIn();
  GeneratedBoolColumn _constructLoggedIn() {
    return GeneratedBoolColumn('logged_in', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _remember_meMeta =
      const VerificationMeta('remember_me');
  GeneratedBoolColumn _remember_me;
  @override
  GeneratedBoolColumn get remember_me =>
      _remember_me ??= _constructRememberMe();
  GeneratedBoolColumn _constructRememberMe() {
    return GeneratedBoolColumn('remember_me', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, logged_in, remember_me];
  @override
  $SettingssTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'settingss';
  @override
  final String actualTableName = 'settingss';
  @override
  VerificationContext validateIntegrity(Insertable<Settings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('logged_in')) {
      context.handle(_logged_inMeta,
          logged_in.isAcceptableOrUnknown(data['logged_in'], _logged_inMeta));
    }
    if (data.containsKey('remember_me')) {
      context.handle(
          _remember_meMeta,
          remember_me.isAcceptableOrUnknown(
              data['remember_me'], _remember_meMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Settings map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Settings.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SettingssTable createAlias(String alias) {
    return $SettingssTable(_db, alias);
  }
}

class Credentials extends DataClass implements Insertable<Credentials> {
  final int id;
  final String username;
  final String password;
  final String userType;
  Credentials(
      {@required this.id,
      @required this.username,
      @required this.password,
      @required this.userType});
  factory Credentials.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Credentials(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      username: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      userType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || userType != null) {
      map['user_type'] = Variable<String>(userType);
    }
    return map;
  }

  CredentialssCompanion toCompanion(bool nullToAbsent) {
    return CredentialssCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      userType: userType == null && nullToAbsent
          ? const Value.absent()
          : Value(userType),
    );
  }

  factory Credentials.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Credentials(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      userType: serializer.fromJson<String>(json['userType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'userType': serializer.toJson<String>(userType),
    };
  }

  Credentials copyWith(
          {int id, String username, String password, String userType}) =>
      Credentials(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        userType: userType ?? this.userType,
      );
  @override
  String toString() {
    return (StringBuffer('Credentials(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('userType: $userType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(username.hashCode, $mrjc(password.hashCode, userType.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Credentials &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.userType == this.userType);
}

class CredentialssCompanion extends UpdateCompanion<Credentials> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> userType;
  const CredentialssCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.userType = const Value.absent(),
  });
  CredentialssCompanion.insert({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.userType = const Value.absent(),
  });
  static Insertable<Credentials> custom({
    Expression<int> id,
    Expression<String> username,
    Expression<String> password,
    Expression<String> userType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (userType != null) 'user_type': userType,
    });
  }

  CredentialssCompanion copyWith(
      {Value<int> id,
      Value<String> username,
      Value<String> password,
      Value<String> userType}) {
    return CredentialssCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      userType: userType ?? this.userType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (userType.present) {
      map['user_type'] = Variable<String>(userType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CredentialssCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('userType: $userType')
          ..write(')'))
        .toString();
  }
}

class $CredentialssTable extends Credentialss
    with TableInfo<$CredentialssTable, Credentials> {
  final GeneratedDatabase _db;
  final String _alias;
  $CredentialssTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedTextColumn _username;
  @override
  GeneratedTextColumn get username => _username ??= _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn('username', $tableName, false,
        defaultValue: const Constant(""));
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn('password', $tableName, false,
        defaultValue: const Constant(""));
  }

  final VerificationMeta _userTypeMeta = const VerificationMeta('userType');
  GeneratedTextColumn _userType;
  @override
  GeneratedTextColumn get userType => _userType ??= _constructUserType();
  GeneratedTextColumn _constructUserType() {
    return GeneratedTextColumn('user_type', $tableName, false,
        defaultValue: const Constant(""));
  }

  @override
  List<GeneratedColumn> get $columns => [id, username, password, userType];
  @override
  $CredentialssTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'credentialss';
  @override
  final String actualTableName = 'credentialss';
  @override
  VerificationContext validateIntegrity(Insertable<Credentials> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username'], _usernameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    }
    if (data.containsKey('user_type')) {
      context.handle(_userTypeMeta,
          userType.isAcceptableOrUnknown(data['user_type'], _userTypeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Credentials map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Credentials.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CredentialssTable createAlias(String alias) {
    return $CredentialssTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SettingssTable _settingss;
  $SettingssTable get settingss => _settingss ??= $SettingssTable(this);
  $CredentialssTable _credentialss;
  $CredentialssTable get credentialss =>
      _credentialss ??= $CredentialssTable(this);
  SettingsDao _settingsDao;
  SettingsDao get settingsDao =>
      _settingsDao ??= SettingsDao(this as MoorDatabase);
  CredentialsDao _credentialsDao;
  CredentialsDao get credentialsDao =>
      _credentialsDao ??= CredentialsDao(this as MoorDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [settingss, credentialss];
}
