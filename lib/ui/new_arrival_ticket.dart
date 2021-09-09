import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/add_new_arrival_ticket_bloc/AddNewArrivalTicketBloc.dart';
import 'package:rma_projekt/bloc/add_new_arrival_ticket_bloc/AddNewArrivalTicketEvent.dart';
import 'package:rma_projekt/bloc/add_new_arrival_ticket_bloc/AddNewArrivalTicketState.dart';
import 'package:rma_projekt/ui/admin_drawer.dart';
import 'package:rma_projekt/ui/admin_pending_tickets_screen.dart';

class NewArrivalTicket extends StatefulWidget {
  const NewArrivalTicket({Key key}) : super(key: key);

  @override
  _NewArrivalTicketState createState() => _NewArrivalTicketState();
}

class _NewArrivalTicketState extends State<NewArrivalTicket> {
  TextEditingController _maxNumOfPeopleController = new TextEditingController();

  AddNewArrivalTicketBloc _addNewArrivalTicketBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _addNewArrivalTicketBloc = AddNewArrivalTicketBloc();
    super.initState();
  }

  @override
  void dispose() {
    _addNewArrivalTicketBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create new arrival ticket"),
      ),
      drawer: AdminDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewArrivalTicketBloc.add(EventAddNewArrivalTicketOnClick(
              int.parse(_maxNumOfPeopleController.text)));
        },
        child: BlocListener(
          bloc: _addNewArrivalTicketBloc,
          listener: (context, state) {
            if (state is StateAddNewArrivalTicketSuccess) {
              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Ticket successfully created")));

              Future.delayed(Duration(seconds: 1), () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AdminPendingTicketsScreen()));
              });
            } else if (state is StateAddNewArrivalTicketFailed) {
              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Failed to create new ticket")));
            }
          },
          child: BlocBuilder(
              bloc: _addNewArrivalTicketBloc,
              builder: (context, state) {
                if (state is StateAddNewArrivalTicketStarted) {
                  return CircularProgressIndicator();
                } else {
                  return Icon(Icons.schedule_send);
                }
              }),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _maxNumOfPeopleController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Max number of people',
                hintText: 'Enter max number of people'),
          ),
        ),
      ),
    );
  }
}
