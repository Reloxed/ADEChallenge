/// Class that defines a detailed venue when the user selects one of the searched venues.
class DetailedVenue {
  late String id;
  late String name;
  late String category;
  late String iconUrl;
  late double distance;
  late double latitude;
  late double longitude;
  late String address;
  late String city;

  // Details
  late String formattedPhone;
  late String website;
  late int hereNow;
  late bool? isOpen;

  DetailedVenue();

  DetailedVenue.full(String id, String name, String category, String iconUrl, double distance, double latitude,
      double longitude, String address, String city, String formattedPhone, String website, int hereNow, bool? isOpen) {
    this.id = id;
    this.name = name;
    this.category = category;
    this.iconUrl = iconUrl;
    this.distance = distance;
    this.latitude = latitude;
    this.longitude = longitude;
    this.address = address;
    this.city = city;
    // Details
    this.formattedPhone = formattedPhone;
    this.website = website;
    this.hereNow = hereNow;
    this.isOpen = isOpen;
  }

  static detailedVenueFromApi(Map<String, dynamic> map) {
    String category = "";
    String url = "";
    double distance = -1.0;
    String city = "";
    String address = "";
    String formattedPhone = "";
    String website = "";
    int hereNow = -1;
    bool? isOpen = null;
    if (map['categories'] != null) {
      category = map['categories'][0]['name'];
      url = map['categories'][0]['icon']['prefix'] + "bg_64" + map['categories'][0]['icon']['suffix'];
    }
    if (map['location']['distance'] != null) {
      distance = map['location']['distance'];
    }
    if (map['location']['city'] != null) {
      city = map['location']['city'];
    }
    if (map['location']['address'] != null) {
      address = map['location']['address'];
    }
    if (map['contact']['formattedPhone'] != null) {
      formattedPhone = map['contact']['formattedPhone'];
    }
    if (map['url'] != null) {
      website = map['url'];
    } else if (map['canonicalUrl'] != null) {
      website = map['canonicalUrl'];
    }
    if (map['hereNow']['count'] != null) {
      hereNow = map['hereNow']['count'];
    }
    if (map['hours'] != null) {
      if (map['hours']['isOpen'] != null) isOpen = map['hours']['isOpen'];
    }
    return new DetailedVenue.full(map['id'], map['name'], category, url, distance, map['location']['lat'],
        map['location']['lng'], address, city, formattedPhone, website, hereNow, isOpen);
  }

  static detailedVenueFromDatabase(Map<String, dynamic> map) {
    return new DetailedVenue.full(
        map['id'],
        map['name'],
        map['category'],
        map['iconUrl'],
        map['distance'],
        map['latitude'],
        map['longitude'],
        map['address'],
        map['city'],
        map['formattedPhone'],
        map['website'],
        map['hereNow'],
        map['isOpen']);
  }

  Map<String, dynamic> detailedVenueToJson() => {
        "id": id,
        "name": name,
        "category": category,
        "iconUrl": iconUrl,
        "distance": distance,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "city": city,
        "formattedPhone": formattedPhone,
        "website": website,
        "hereNow": hereNow,
        "isOpen": isOpen,
      };
}
