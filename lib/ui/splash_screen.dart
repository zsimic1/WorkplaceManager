import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rma_projekt/model/database/moor_database.dart';
import 'package:rma_projekt/model/enums/UserType.dart';
import 'package:rma_projekt/ui/admin_pending_tickets_screen.dart';
import 'package:rma_projekt/ui/login_screen.dart';

import 'user_new_arrival_tickets.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  double _iconSize = 60;

  Future checkFirstSeen() async {
    // init firebase
    // await cf.FirebaseFirestore.instance.clearPersistence();
    await Firebase.initializeApp();
    cf.FirebaseFirestore.instance.settings =
        cf.Settings(persistenceEnabled: false);

    var _settingsDao = MoorDatabase().settingsDao;
    var _settings = await _settingsDao.getSettings();

    // no credentials yet, insert default ones
    var _credentialsDao = MoorDatabase().credentialsDao;
    var _credentials = await _credentialsDao.getCredentials();
    if (_credentials == null) {
      _credentialsDao.insertDefaultCredentials();
    }

    // no settings yet, insert default ones
    if (_settings == null) {
      await _settingsDao.insertDefaultSettings();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    // user is logged in
    else if (_settings.logged_in) {
      var _credentialsDao = MoorDatabase().credentialsDao;
      var _credentials = await _credentialsDao.getCredentials();
      if (_credentials == null) {
        _credentialsDao.insertDefaultCredentials();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else if (_credentials.userType == UserType.ADMIN) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AdminPendingTicketsScreen()));
      } else if (_credentials.userType == UserType.USER) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserNewArrivalTickets()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    }
    // not logged in
    else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pending_actions, size: 80, color: Colors.grey[700]),
          SizedBox(
            height: 10,
          ),
          Text(
            "RMA project app",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400]),
          ),
        ],
      )),
    );
  }
}
