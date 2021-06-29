import 'package:adechallenge/api/four_square.dart';
import 'package:flutter/material.dart';

import '../detailed_venue.dart';

class DetailedVenueProvider extends ChangeNotifier {
  late DetailedVenue detailedVenue = DetailedVenue();
  bool loading = false;

  getApiData(String id) async{
    loading = true;
    detailedVenue = await getDetailedVenue(id);
    loading = false;

    notifyListeners();
  }
}