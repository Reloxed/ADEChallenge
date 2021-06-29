import 'package:adechallenge/api/four_square.dart';
import 'package:adechallenge/database/queries.dart';
import 'package:flutter/material.dart';

import '../detailed_venue.dart';

class DetailedVenueProvider extends ChangeNotifier {
  late DetailedVenue detailedVenue = DetailedVenue();
  List<DetailedVenue> favorites = [];
  bool loading = false;
  bool isFavorite = false;

  /// Asks the FourSquare API for data with the given venue's ID.
  getApiData(String id) async{
    loading = true;
    detailedVenue = await getDetailedVenue(id);
    loading = false;

    notifyListeners();
  }

  /// Retrieves the detailed venue directly from Firestore database.
  getDataFromDatabase(DetailedVenue detailedVenue) {
    this.detailedVenue = detailedVenue;

    notifyListeners();
  }

  /// Retrieves the favorite list from the Firestore database for the logged in user.
  getFavoriteListFromDatabase() async {
    loading = true;
    favorites = await getFavorites();
    loading = false;

    notifyListeners();
  }

  /// Retrieves if the current user has the given venue saved in favorites, checking the Firestore database
  getIsFavoriteFromDatabase(String id) async {
    loading = true;
    this.isFavorite = await isVenueFavorite(id);
    loading = false;

    notifyListeners();
  }

  /// Sets favorite widget to the given value.
  setFavorite(bool favorite) {
    isFavorite = favorite;

    notifyListeners();
  }
}