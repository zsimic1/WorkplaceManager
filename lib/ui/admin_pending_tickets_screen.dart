import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_bloc/AdminPendingTicketsBloc.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_bloc/AdminPendingTicketsEvent.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_bloc/AdminPendingTicketsState.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_busyness_bloc/AdminPendingTicketsBusynessBloc.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_busyness_bloc/AdminPendingTicketsBusynessState.dart';
import 'package:rma_projekt/bloc/admin_resolve_ticket_bloc/AdminResolveTicketsBloc.dart';
import 'package:rma_projekt/bloc/admin_resolve_ticket_bloc/AdminResolveTicketsEvent.dart';
import 'package:rma_projekt/model/entity/PendingTicket.dart';
import 'package:rma_projekt/ui/admin_drawer.dart';
import 'package:rma_projekt/ui/pending_tickets_day_container.dart';

class AdminPendingTicketsScreen extends StatefulWidget {
  const AdminPendingTicketsScreen({Key key}) : super(key: key);

  @override
  _AdminPendingTicketsScreenState createState() =>
      _AdminPendingTicketsScreenState();
}

class _AdminPendingTicketsScreenState extends State<AdminPendingTicketsScreen> {
  AdminPendingTicketBloc _adminPendingTicketBloc;
  AdminResolveTicketBloc _adminResolveTicketBloc;

  @override
  void initState() {
    _adminPendingTicketBloc = AdminPendingTicketBloc();
    _adminResolveTicketBloc = AdminResolveTicketBloc();

    _adminPendingTicketBloc.add(EventAdminPendingTicketOnInit());

    super.initState();
  }

  @override
  void dispose() {
    _adminPendingTicketBloc.close();
    _adminResolveTicketBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pending Tickets"),
        ),
        drawer: AdminDrawer(),
        body: BlocListener(
          bloc: _adminPendingTicketBloc,
          listener: (context, state) {
            if (state is StateAdminPendingTicketDone) {}
          },
          child: BlocBuilder(
            bloc: _adminPendingTicketBloc,
            builder: (context, state) {
              if (state is StateAdminPendingTicketOnInit) {
                return Container();
              } else if (state is StateAdminPendingTicketFetchingTickets) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is StateAdminPendingTicketDone) {
                if (state.tickets.isEmpty) {
                  return Center(
                    child: Text(
                      "All Tickets Resolved",
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
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_ticket.firstLastName),
                            Text(
                              " · " + _ticket.ticket.id.substring(0, 8),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(color: Colors.grey[400]),
                            )
                          ],
                        ),
                        subtitle: buildDaysRow(_ticket),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            buildButtons(
                                _ticket.ticket.id, _ticket.ticket.userUsername),
                            Text("\\${_ticket.ticket.maxNumOfPeople}",
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else
                return Container();
            },
          ),
        ));
  }

  Row buildDaysRow(PendingTicket _ticket) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PendingTicketDaysContainer(
          dayLetter: "Mo",
          arrive: _ticket.ticket.arriveDays[0],
          index: 0,
          ticketID: _ticket.ticket.id,
          maxNum: _ticket.ticket.maxNumOfPeople,
        ),
        PendingTicketDaysContainer(
          dayLetter: "Tu",
          arrive: _ticket.ticket.arriveDays[1],
          index: 1,
          ticketID: _ticket.ticket.id,
          maxNum: _ticket.ticket.maxNumOfPeople,
        ),
        PendingTicketDaysContainer(
          dayLetter: "We",
          arrive: _ticket.ticket.arriveDays[2],
          index: 2,
          ticketID: _ticket.ticket.id,
          maxNum: _ticket.ticket.maxNumOfPeople,
        ),
        PendingTicketDaysContainer(
          dayLetter: "TH",
          arrive: _ticket.ticket.arriveDays[3],
          index: 3,
          ticketID: _ticket.ticket.id,
          maxNum: _ticket.ticket.maxNumOfPeople,
        ),
        PendingTicketDaysContainer(
          dayLetter: "Fr",
          arrive: _ticket.ticket.arriveDays[4],
          index: 4,
          ticketID: _ticket.ticket.id,
          maxNum: _ticket.ticket.maxNumOfPeople,
        ),
      ],
    );
  }

  Widget buildButtons(String ticketID, String username) {
    var _size = 40.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            // accept
            _adminResolveTicketBloc
                .add(EventAdminResolveTicketOnAccept(ticketID, username));
          },
          child: Container(
            width: _size,
            height: _size,
            color: Colors.green[600],
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            // decline
            _adminResolveTicketBloc
                .add(EventAdminResolveTicketOnDecline(ticketID, username));
          },
          child: Container(
            width: _size,
            height: _size,
            color: Colors.red[600],
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
