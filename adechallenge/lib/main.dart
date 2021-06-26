import 'package:adechallenge/models/venue_provider.dart';
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
  ];

  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        primarySwatch: Colors.lightGreen,
        accentColor: Colors.blue[200]
      ),
      home: Login(),
    );
  }
}
