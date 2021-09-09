import 'package:rma_projekt/model/enums/UserCollection.dart';

class User {
  String firstName;
  String lastName;
  String username;
  String password;
  String type;

  User(String firstName, String lastName, String username, String password,
      String type) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.password = password;
    this.type = type;
  }

  Map<String, dynamic> toJsonMap() {
    return {
      UserCollection.FIRST_NAME: this.firstName,
      UserCollection.LAST_NAME: this.lastName,
      UserCollection.USERNAME: this.username,
      UserCollection.PASSWORD: this.password,
      UserCollection.TYPE: this.type
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json[UserCollection.FIRST_NAME],
      json[UserCollection.LAST_NAME],
      json[UserCollection.USERNAME],
      json[UserCollection.PASSWORD],
      json[UserCollection.TYPE],
    );
  }

  String getFirstLastNameString(){
    return this.firstName + " " + this.lastName;
  }
}
