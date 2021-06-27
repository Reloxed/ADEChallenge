import 'dart:async';

import 'package:adechallenge/models/detailed_venue_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/* Screen where the details are shown to the user alongside the map that shows its location.*/
class DetailsVenue extends StatefulWidget {
  @override
  _DetailsVenueState createState() {
    return _DetailsVenueState();
  }
}

class _DetailsVenueState extends State<DetailsVenue> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DetailedVenueProvider>(context);
    MarkerId markerId = new MarkerId(provider.detailedVenue!.name);
    List<Marker> markers = [
      new Marker(
        markerId: markerId,
        position: new LatLng(provider.detailedVenue!.latitude, provider.detailedVenue!.longitude),
      )
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("ADEChallenge"),
      ),
      body: provider.loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: GoogleMap(
                    rotateGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      zoomControlsEnabled: true,
                      myLocationEnabled: false,
                      initialCameraPosition: new CameraPosition(
                          target: new LatLng(provider.detailedVenue!.latitude, provider.detailedVenue!.longitude),
                          zoom: 12),
                      markers: markers.toSet())
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height /2),
                  height: MediaQuery.of(context).size.height /2,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10.0),
                        child:
                        Text(provider.detailedVenue!.name, style: Theme.of(context).textTheme.headline5)
                      ),

                    ],
                  )
                )
              ],
            ),
    );
  }
}
