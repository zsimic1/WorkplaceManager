import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/add_new_user/AddNewUserBloc.dart';
import 'package:rma_projekt/bloc/add_new_user/AddNewUserEvent.dart';
import 'package:rma_projekt/bloc/add_new_user/AddNewUserState.dart';
import 'package:rma_projekt/ui/admin_drawer.dart';

import 'admin_pending_tickets_screen.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({Key key}) : super(key: key);

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  AddNewUserBloc _addNewUserBloc;

  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _addNewUserBloc = AddNewUserBloc();
    super.initState();
  }

  @override
  void dispose() {
    _addNewUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Create New User"),
        ),
        drawer: AdminDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addNewUserBloc.add(EventAddNewUserOnClick(
              _firstNameController.text,
              _lastNameController.text,
              _usernameController.text,
              _passController.text,
            ));
          },
          child: BlocBuilder(
            bloc: _addNewUserBloc,
            builder: (context, state) {
              if (state is StateAddNewUserStarted) {
                return CircularProgressIndicator();
              } else {
                return Icon(Icons.add);
              }
            },
          ),
          backgroundColor: Colors.green,
        ),
        body: BlocListener(
          bloc: _addNewUserBloc,
          listener: (context, state) {
            if (state is StateAddNewUserSuccess) {
              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(content: new Text("User successfully created")));

              Future.delayed(Duration(seconds: 1), () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AdminPendingTicketsScreen()));
              });
            } else if (state is StateAddNewUserFailedFillAllInputs) {
              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(content: new Text("Please fill all inputs")));
            } else if (state is StateAddNewUserFailed){
              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(content: new Text("Failed to add new user")));
            } else if (state is StateAddNewUserFailedUsernameTaken){
              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(content: new Text("Username already taken")));
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 200, left: 10, right: 10, bottom: 30),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'first name',
                            hintText: 'Enter first name'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'last name',
                            hintText: 'Enter last name'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'username',
                            hintText: 'Enter username'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'password',
                            hintText: 'Enter password'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
