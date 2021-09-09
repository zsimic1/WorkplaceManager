import 'package:rma_projekt/model/enums/ArrivalCollection.dart';

class ArrivalTicket {
  String id;
  String userUsername;
  String status;
  List<bool> arriveDays;
  DateTime dateCreated;
  int maxNumOfPeople;

  ArrivalTicket(String id, String userUsername, String status,
      List<bool> arriveDays, DateTime dateCreated, int maxNUmOfPeople) {
    this.id = id;
    this.userUsername = userUsername;
    this.status = status;
    this.arriveDays = arriveDays;
    this.dateCreated = dateCreated;
    this.maxNumOfPeople = maxNUmOfPeople;
  }

  Map<String, dynamic> toJsonMap() {
    return {
      ArrivalCollection.ID: this.id,
      ArrivalCollection.USER_USERNAME: this.userUsername,
      ArrivalCollection.STATUS: this.status,
      ArrivalCollection.ARRIVE_DAYS: this.arriveDays,
      ArrivalCollection.DATE_CREATED: this.dateCreated,
      ArrivalCollection.MAX_NUM_OF_PEOPLE: this.maxNumOfPeople
    };
  }

  factory ArrivalTicket.fromJson(Map<String, dynamic> json) {
    return ArrivalTicket(
        json[ArrivalCollection.ID],
        json[ArrivalCollection.USER_USERNAME],
        json[ArrivalCollection.STATUS],
        List<bool>.from(json[ArrivalCollection.ARRIVE_DAYS]),
        json[ArrivalCollection.DATE_CREATED].toDate(),
        json[ArrivalCollection.MAX_NUM_OF_PEOPLE]);
  }
}
