import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rma_projekt/bloc/login_bloc/LoginBloc.dart';
import 'package:rma_projekt/bloc/login_bloc/LoginEvent.dart';
import 'package:rma_projekt/bloc/login_bloc/LoginState.dart';
import 'package:rma_projekt/model/enums/UserType.dart';
import 'package:rma_projekt/ui/admin_pending_tickets_screen.dart';
import 'package:rma_projekt/ui/user_new_arrival_tickets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  var _rememberMeCheckboxValue = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  void initState() {
    _loginBloc = LoginBloc();

    _loginBloc.add(EventLoginOnInit());
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: SingleChildScrollView(
        child: BlocListener(
          bloc: _loginBloc,
          listener: (context, state) {
            if (state is StateLoginSuccess) {
              // check which type user is (admin/user)
              if (state.userType == UserType.ADMIN) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AdminPendingTicketsScreen()));
              } else if (state.userType == UserType.USER) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserNewArrivalTickets()));
              }
            } else if (state is StateLoginFailed) {
              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(content: new Text("Login failed")));
            } else if (state is StateLoginFetchedDefaults) {
              _usernameController.text = state.username;
              _passController.text = state.password;
              setState(() {
                _rememberMeCheckboxValue = state.rememberMe;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: 200, left: 10, right: 10, bottom: 30),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                          hintText: 'Enter your username'),
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
                          hintText: 'Enter your password'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          title: Text(
                            "Remember me",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                          //    <-- label
                          value: _rememberMeCheckboxValue,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (newValue) {
                            setState(() {
                              _rememberMeCheckboxValue = newValue;
                            });
                          },
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: FlatButton(
                              onPressed: () {
                                _loginBloc.add(EventLoginOnLoginPress(
                                    _usernameController.text,
                                    _passController.text,
                                    _rememberMeCheckboxValue));
                              },
                              child: BlocBuilder(
                                bloc: _loginBloc,
                                builder:
                                    (BuildContext context, LoginState state) {
                                  if (state is StateLoginOnInit ||
                                      state is StateLoginFailed ||
                                      state is StateLoginFetchedDefaults) {
                                    return Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    );
                                  } else {
                                    return CircularProgressIndicator(
                                      backgroundColor: Colors.grey[500],
                                    );
                                  }
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
