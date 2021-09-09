import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/user_new_arrival_ticket_bloc/UserNewArrivalTicketBloc.dart';
import 'package:rma_projekt/bloc/user_new_arrival_ticket_bloc/UserNewArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/user_new_arrival_ticket_bloc/UserNewArrivalTicketState.dart';
import 'package:rma_projekt/bloc/user_save_new_arrival_ticket_bloc/UserSaveNewArrivalTicketBloc.dart';
import 'package:rma_projekt/bloc/user_save_new_arrival_ticket_bloc/UserSaveNewArrivalTicketEvent.dart';
import 'package:rma_projekt/ui/user_drawer.dart';

class UserNewArrivalTickets extends StatefulWidget {
  const UserNewArrivalTickets({Key key}) : super(key: key);

  @override
  _UserNewArrivalTicketsState createState() => _UserNewArrivalTicketsState();
}

class _UserNewArrivalTicketsState extends State<UserNewArrivalTickets> {
  UserNewArrivalTicketBloc _userNewArrivalTicketsBloc;
  UserSaveNewArrivalTicketBloc _userSaveNewArrivalTicketsBloc;

  @override
  void initState() {
    _userNewArrivalTicketsBloc = UserNewArrivalTicketBloc();
    _userSaveNewArrivalTicketsBloc = UserSaveNewArrivalTicketBloc();
    _userNewArrivalTicketsBloc.add(EventUserNewArrivalTicketOnInit());

    super.initState();
  }

  @override
  void dispose() {
    _userNewArrivalTicketsBloc.close();
    _userSaveNewArrivalTicketsBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New arrival tickets"),
        ),
        drawer: UserDrawer(),
        body: BlocBuilder(
          bloc: _userNewArrivalTicketsBloc,
          builder: (context, state) {
            if (state is StateUserNewArrivalTicketOnInit) {
              return Container();
            } else if (state is StateUserNewArrivalTicketFetchingTickets) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateUserNewArrivalTicketDone) {
              if(state.tickets.isEmpty){
                return Center(child: Text("All Tickets Submitted", style: TextStyle(fontSize: 23, color: Colors.grey[500]),),);
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "New ticket request",
                                style: TextStyle(
                                    fontSize: 21, color: Colors.grey[800]),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Colors.white,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        _userSaveNewArrivalTicketsBloc.add(
                                            EventUserSaveNewArrivalTicketOnSave(
                                                _ticket.id,
                                                _ticket.arriveDays));
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        buildDayContainer(
                            0, "Monday", _ticket.arriveDays[0], _ticket.id),
                        buildDayContainer(
                            1, "Tuesday", _ticket.arriveDays[1], _ticket.id),
                        buildDayContainer(
                            2, "Wednesday", _ticket.arriveDays[2], _ticket.id),
                        buildDayContainer(
                            3, "Thursday", _ticket.arriveDays[3], _ticket.id),
                        buildDayContainer(
                            4, "Friday", _ticket.arriveDays[4], _ticket.id),
                      ],
                    ),
                  );
                },
              );
            } else
              return Container();
          },
        ));
  }

  Container buildDayContainer(
      int index, String day, bool value, String ticketID) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), color: Colors.grey[50]),
      child: CheckboxListTile(
        title: Text(day),
        value: value,
        onChanged: (newValue) {
          setState(() {
            _userNewArrivalTicketsBloc.add(
                EventUserNewArrivalTicketCheckboxClicked(
                    index, newValue, ticketID));
          });
        },
      ),
    );
  }
}
