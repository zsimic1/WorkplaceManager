import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_busyness_bloc/AdminPendingTicketsBusynessBloc.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_busyness_bloc/AdminPendingTicketsBusynessEvent.dart';
import 'package:rma_projekt/bloc/admin_pending_tickets_busyness_bloc/AdminPendingTicketsBusynessState.dart';

class PendingTicketDaysContainer extends StatefulWidget {
  const PendingTicketDaysContainer(
      {Key key,
      this.dayLetter,
      this.arrive,
      this.index,
      this.ticketID,
      this.maxNum})
      : super(key: key);
  final String dayLetter;
  final bool arrive;
  final String ticketID;
  final int index;
  final int maxNum;

  @override
  _PendingTicketDaysContainerState createState() =>
      _PendingTicketDaysContainerState();
}

class _PendingTicketDaysContainerState
    extends State<PendingTicketDaysContainer> {
  AdminPendingTicketBusynessBloc _adminPendingTicketBusynessBloc;

  @override
  void initState() {
    super.initState();
    _adminPendingTicketBusynessBloc = AdminPendingTicketBusynessBloc();
    _adminPendingTicketBusynessBloc
        .add(EventAdminPendingTicketBusynessOnInit(widget.ticketID));
  }

  @override
  void dispose() {
    _adminPendingTicketBusynessBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        color: widget.arrive == true ? Colors.green[400] : Colors.red[400],
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Text(
                widget.dayLetter,
                style: TextStyle(color: Colors.white),
              )),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 10,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              BlocBuilder(
                  bloc: _adminPendingTicketBusynessBloc,
                  builder: (context, state) {
                    if (state is StateAdminPendingTicketBusynessOnInit) {
                      return Container(
                        width: 20,
                        height: 20,
                      );
                    } else if (state
                        is StateAdminPendingTicketBusynessFetchingTickets) {
                      return Container(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator());
                    } else if (state is StateAdminPendingTicketBusynessDone) {
                      return buildBusynessWidget(state.busyness, widget.index);
                    } else
                      return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBusynessWidget(List<int> busyness, int index) {
    var _num = busyness[index];

    return Center(
      child: Container(
        child: Text("$_num",
            style: TextStyle(
                fontSize: 16,
                color: _num >= widget.maxNum ? Colors.red : Colors.grey[300],
                shadows: _num >= widget.maxNum
                    ? <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 1.5,
                            color: Colors.white),
                        Shadow(
                            offset: Offset(1.0, -1.0),
                            blurRadius: 1.5,
                            color: Colors.white),
                        Shadow(
                            offset: Offset(-1.0, 1.0),
                            blurRadius: 1.5,
                            color: Colors.white),
                        Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 1.5,
                            color: Colors.white)
                      ]
                    : null)),
      ),
    );
  }
}
