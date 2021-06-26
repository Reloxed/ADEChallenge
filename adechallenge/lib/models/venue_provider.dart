import 'package:adechallenge/api/four_square.dart';
import 'package:adechallenge/models/venue.dart';
import 'package:flutter/cupertino.dart';

class VenueProvider extends ChangeNotifier {
  List<Venue> venues = [];
  bool loading = false;

  getApiData(String name, String location) async {
    loading = true;
    venues = await getVenues(name, location);
    loading = false;

    notifyListeners();
  }
}