import 'dart:async';

import '../models/providers/venue_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/* Map where the venues searched are shown.*/
class MapVenues extends StatefulWidget {
  @override
  _MapVenuesState createState() {
    return new _MapVenuesState();
  }
}

class _MapVenuesState extends State<MapVenues> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VenueProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("ADEChallenge"),
      ),
      body: provider.loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : GoogleMap(
              myLocationEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  new CameraPosition(target: new LatLng(provider.averageLat, provider.averageLon), zoom: 12),
              markers: provider.markers,
            ),
    );
  }
}
