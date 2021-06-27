import 'package:adechallenge/models/detailed_venue_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Screen where the details are shown to the user alongside the map that shows its location.*/
class DetailsVenue extends StatefulWidget {
  @override
  _DetailsVenueState createState() {
    return _DetailsVenueState();
  }
}

class _DetailsVenueState extends State<DetailsVenue> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DetailedVenueProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("ADEChallenge"),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
  
}