import 'package:adechallenge/api/four_square.dart';
import 'detailed_venue_provider.dart';
import 'package:adechallenge/models/venue.dart';
import 'package:adechallenge/utils/navigations.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/* Auxiliary class for the provider state management to manage Venues searched.*/
class VenueProvider extends ChangeNotifier {
  List<Venue> venues = [];
  bool loading = false;
  double averageLat = 0.0;
  double averageLon = 0.0;
  Set<Marker> markers = Set();

  /* Returns Foursquare API data using the auxiliary method getVenues */
  getApiData(String name, String location) async {
    loading = true;
    venues = await getVenues(name, location);
    loading = false;

    notifyListeners();
  }

  /* Gets the center of the map when the venues are shown on it, averaging the latitude and the longitude */
  getAverageCoor() {
    loading = true;

    double sumLat = 0.0;
    double sumLon = 0.0;
    for (int i = 0; i < venues.length; i++) {
      sumLat += venues.elementAt(i).latitude;
      sumLon += venues.elementAt(i).longitude;
    }
    averageLat = sumLat / venues.length;
    averageLon = sumLon / venues.length;

    loading = false;

    notifyListeners();
  }

  /* Generates markers for the map for all the venues retrieved from the API*/
  getMarkers(BuildContext context) {
    var provider = Provider.of<DetailedVenueProvider>(context, listen: false);
    loading = true;

    for (int i = 0; i < venues.length; i++) {
      MarkerId markerId = new MarkerId(i.toString());
      Marker m = new Marker(
          markerId: markerId,
          position: new LatLng(venues.elementAt(i).latitude, venues.elementAt(i).longitude),
          infoWindow: InfoWindow(
              title: venues.elementAt(i).name,
              snippet: "Más detalles",
              onTap: () {
                navigateToDetailedVenue(context);
                provider.getApiData(venues.elementAt(i).id);
              }));
      markers.add(m);
    }

    loading = false;

    notifyListeners();
  }
}
