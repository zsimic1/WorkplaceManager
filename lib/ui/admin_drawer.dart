import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/logout_bloc/LogoutBloc.dart';
import 'package:rma_projekt/bloc/logout_bloc/LogoutEvent.dart';
import 'package:rma_projekt/bloc/logout_bloc/LogoutState.dart';
import 'package:rma_projekt/ui/admin_old_arrival_tickets.dart';
import 'package:rma_projekt/ui/login_screen.dart';
import 'package:rma_projekt/ui/new_arrival_ticket.dart';
import 'package:rma_projekt/ui/new_user_screen.dart';

import 'admin_pending_tickets_screen.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key key}) : super(key: key);

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  LogoutBloc _logoutBloc;

  @override
  void initState() {
    _logoutBloc = LogoutBloc();
    super.initState();
  }

  @override
  void dispose() {
    _logoutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocListener(
        bloc: _logoutBloc,
        listener: (context, state) {
          if (state is StateLogoutDone) {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              // accountName: Text("First and last name"),
              // accountEmail: Text("username"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.pending_actions,
                    size: 60, color: Colors.grey[700]),
              ),
            ),
            ListTile(
              leading: Icon(Icons.next_week_outlined),
              title: Text("Pending arrival tickets"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminPendingTicketsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.fiber_new),
              title: Text("Create new arrival ticket"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewArrivalTicket()));
              },
            ),
            ListTile(
              leading: Icon(Icons.pending_actions),
              title: Text("All arrival tickets"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminOldArrivalTickets()));
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new),
              title: Text("New user"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NewUserScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: BlocBuilder(
                bloc: _logoutBloc,
                builder: (context, state) {
                  if (state is StateLogoutStarted || state is StateLogoutDone) {
                    return Text("Logging out...");
                  } else {
                    return Text("Logout");
                  }
                },
              ),
              onTap: () {
                _logoutBloc.add(EventLogoutOnButtonPress());
              },
            ),
          ],
        ),
      ),
    );
  }
}
