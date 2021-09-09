import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/admin_old_arrival_ticket_bloc/AdminOldArrivalTicketBloc.dart';
import 'package:rma_projekt/bloc/admin_old_arrival_ticket_bloc/AdminOldArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/admin_old_arrival_ticket_bloc/AdminOldArrivalTicketState.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/ui/admin_drawer.dart';

class AdminOldArrivalTickets extends StatefulWidget {
  const AdminOldArrivalTickets({Key key}) : super(key: key);

  @override
  _AdminOldArrivalTickets createState() => _AdminOldArrivalTickets();
}

class _AdminOldArrivalTickets extends State<AdminOldArrivalTickets> {
  AdminOldArrivalTicketBloc _adminOldArrivalTicketsBloc;

  @override
  void initState() {
    _adminOldArrivalTicketsBloc = AdminOldArrivalTicketBloc();
    _adminOldArrivalTicketsBloc.add(EventAdminOldArrivalTicketOnInit());

    super.initState();
  }

  @override
  void dispose() {
    _adminOldArrivalTicketsBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All arrival tickets"),
        ),
        drawer: AdminDrawer(),
        body: BlocBuilder(
          bloc: _adminOldArrivalTicketsBloc,
          builder: (context, state) {
            if (state is StateAdminOldArrivalTicketOnInit) {
              return Container();
            } else if (state is StateAdminOldArrivalTicketFetchingTickets) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateAdminOldArrivalTicketDone) {
              if (state.tickets.isEmpty) {
                return Center(
                  child: Text(
                    "No Tickets Yet",
                    style: TextStyle(fontSize: 23, color: Colors.grey[500]),
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.tickets.length,
                itemBuilder: (c, index) {
                  var _ticket = state.tickets[index];
                  return Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey)),
                    child: ListTile(
                      title:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_ticket.firstLastName),
                          Text(
                            " · " + _ticket.ticket.id.substring(0, 8),
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildDaysContainers(
                              "Mo", _ticket.ticket.arriveDays[0]),
                          buildDaysContainers(
                              "Tu", _ticket.ticket.arriveDays[1]),
                          buildDaysContainers(
                              "We", _ticket.ticket.arriveDays[2]),
                          buildDaysContainers(
                              "Th", _ticket.ticket.arriveDays[3]),
                          buildDaysContainers(
                              "Fr", _ticket.ticket.arriveDays[4]),
                        ],
                      ),
                      trailing: buildStatus(_ticket.ticket.status),
                    ),
                  );
                },
              );
            } else
              return Container();
          },
        ));
  }

  Widget buildStatus(String status) {
    IconData _icon;
    MaterialColor _color;

    if (status == ArrivalStatusType.WAITING_FOR_APPROVAL) {
      _icon = Icons.watch_later;
      _color = Colors.orange;
    } else if (status == ArrivalStatusType.APPROVED) {
      _icon = Icons.check;
      _color = Colors.green;
    } else if (status == ArrivalStatusType.DECLINED) {
      _icon = Icons.clear;
      _color = Colors.red;
    } else {
      _icon = Icons.device_unknown;
      _color = Colors.brown;
    }

    return Container(
      decoration: BoxDecoration(
          color: _color[200],
          border: Border.all(
            color: _color[200],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          _icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildDaysContainers(String dayLetter, bool arrive) {
    var _size = 30.0;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        width: _size,
        height: _size,
        color: arrive == true ? Colors.green[500] : Colors.red[500],
        child: Center(
            child: Text(
          dayLetter,
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
