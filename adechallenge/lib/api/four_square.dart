import 'dart:convert';

import 'package:adechallenge/models/detailed_venue.dart';
import 'package:adechallenge/models/venue.dart';
import 'package:http/http.dart' as http;

/* Consults the FourSquare API to get venues according to the name and location given. Returns the list of venues.*/
Future<List<Venue>> getVenues(String name, String location) async {
  List<Venue> res = [];
  String clientId = "BCPCG5H50N0IIKRG0YZWXNSU1XKBA0FRBIAU25O4BKPMLESU";
  String secret = "AVQNXQ2LD01BIXLD2UWJGL0IR5BDBMZFA3UEHDQFNBJMVC3R";

  var url = Uri.parse("https://api.foursquare.com/v2/venues/search?client_id=" +
      clientId +
      "&client_secret=" +
      secret +
      "&query=" +
      name +
      "&near=" +
      location +
      "&limit=10&v=20210626");

  var response = await http.get(url);

  Map<String, dynamic> map = jsonDecode(response.body);

  if (map['meta']['code'] == 200) {
    if (map['response']['venues'].length > 0) {
      for (int i = 0; i < map['response']['venues'].length; i++) {
        Venue venue = Venue.venueFromApi(map['response']['venues'][i]);
        res.add(venue);
      }
    }
  }

  return res;
}

/* Consults the FourSquare API to get details of a given venue by its ID*/
Future<DetailedVenue> getDetailedVenue(String id) async {
  DetailedVenue detailedVenue = DetailedVenue();
  String clientId = "BCPCG5H50N0IIKRG0YZWXNSU1XKBA0FRBIAU25O4BKPMLESU";
  String secret = "AVQNXQ2LD01BIXLD2UWJGL0IR5BDBMZFA3UEHDQFNBJMVC3R";

  var url = Uri.parse("https://api.foursquare.com/v2/venues/" +
      id +
      "?client_id=" +
      clientId +
      "&client_secret=" +
      secret +
      "&v=20210626");

  var response = await http.get(url);

  Map<String, dynamic> map = jsonDecode(response.body);

  if (map['meta']['code'] == 200) {
    detailedVenue = DetailedVenue.detailedVenueFromApi(map['response']['venue']);
  }
  return detailedVenue;
}
