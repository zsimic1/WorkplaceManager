import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/user_old_arrival_ticket_bloc/UserOldArrivalTicketBloc.dart';
import 'package:rma_projekt/bloc/user_old_arrival_ticket_bloc/UserOldArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/user_old_arrival_ticket_bloc/UserOldArrivalTicketState.dart';
import 'package:rma_projekt/model/enums/ArrivalStatusType.dart';
import 'package:rma_projekt/ui/user_drawer.dart';

class UserOldArrivalTickets extends StatefulWidget {
  const UserOldArrivalTickets({Key key}) : super(key: key);

  @override
  _UserOldArrivalTickets createState() => _UserOldArrivalTickets();
}

class _UserOldArrivalTickets extends State<UserOldArrivalTickets> {
  UserOldArrivalTicketBloc _userOldArrivalTicketsBloc;

  @override
  void initState() {
    _userOldArrivalTicketsBloc = UserOldArrivalTicketBloc();
    _userOldArrivalTicketsBloc.add(EventUserOldArrivalTicketOnInit());

    super.initState();
  }

  @override
  void dispose() {
    _userOldArrivalTicketsBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All arrival tickets"),
        ),
        drawer: UserDrawer(),
        body: BlocBuilder(
          bloc: _userOldArrivalTicketsBloc,
          builder: (context, state) {
            if (state is StateUserOldArrivalTicketOnInit) {
              return Container();
            } else if (state is StateUserOldArrivalTicketFetchingTickets) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateUserOldArrivalTicketDone) {
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
                      title: Text(_ticket.id.substring(0, 8)),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildDaysContainers("Mo", _ticket.arriveDays[0]),
                          buildDaysContainers("Tu", _ticket.arriveDays[1]),
                          buildDaysContainers("We", _ticket.arriveDays[2]),
                          buildDaysContainers("Th", _ticket.arriveDays[3]),
                          buildDaysContainers("Fr", _ticket.arriveDays[4]),
                        ],
                      ),
                      trailing: buildStatus(_ticket.status),
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

  Container buildDaysContainers(String dayLetter, bool arrive) {
    var _size = 30.0;
    return Container(
      width: _size,
      height: _size,
      color: arrive == true ? Colors.green[500] : Colors.red[500],
      child: Center(
          child: Text(
        dayLetter,
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
