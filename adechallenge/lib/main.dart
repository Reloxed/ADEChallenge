import 'package:adechallenge/screens/search_venues.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/providers/detailed_venue_provider.dart';
import 'models/providers/venue_provider.dart';
import 'package:adechallenge/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<VenueProvider>(create: (_) => VenueProvider()),
    ChangeNotifierProvider<DetailedVenueProvider>(create: (_) => DetailedVenueProvider())
  ];

  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.lightGreen, primarySwatch: Colors.lightGreen, accentColor: Colors.blue[200]),
      home: FutureBuilder<bool>(
        future: checkIfUserIsLogged(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Material(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("ADEChallenge"),
                ),
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          } else {
            return snapshot.requireData == true ? SearchVenues() : Login();
          }
        },
      ),
    );
  }

  Future<bool> checkIfUserIsLogged() async {
    bool logged = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get("loggedUser") != null) {
      logged = true;
    }
    return logged;
  }
}
