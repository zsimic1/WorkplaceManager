import 'package:rma_projekt/model/entity/ArrivalTicket.dart';

class PendingTicket{
  ArrivalTicket ticket;
  String firstLastName;

  PendingTicket(ArrivalTicket ticket, String firstLastName){
    this.ticket = ticket;
    this.firstLastName = firstLastName;
  }
}