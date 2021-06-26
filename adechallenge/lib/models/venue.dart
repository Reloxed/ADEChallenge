class Venue {
  late String id;
  late String name;
  late String category;
  late String iconUrl;
  late double distance;
  late double latitude;
  late double longitude;
  late String address;
  late String city;
  late int hereNow;

  Venue(String id, String name, String category, String iconUrl, double distance, double latitude, double longitude,
      String address, String city, int hereNow){
    this.id = id;
    this.name = name;
    this.category = category;
    this.iconUrl = iconUrl;
    this.distance = distance;
    this.latitude = latitude;
    this.longitude = longitude;
    this.address = address;
    this.city = city;
    this.hereNow = hereNow;
  }

  static venueFromApi(Map<String, dynamic> map) {
    String category = "";
    String url = "";
    int hereNow = -1;
    double distance = -1.0;
    String city = "";
    String address = "";
    if(map['categories'] != null) {
      category = map['categories'][0]['name'];
      url = map['categories'][0]['icon']['prefix'] + "bg_64" + map['categories'][0]['icon']['suffix'];
    }
    if(map['hereNow'] != null) {
      hereNow = map['hereNow']['count'];
    }
    if(map['location']['distance'] != null) {
      distance = map['location']['distance'];
    }
    if(map['location']['city'] != null) {
      city = map['location']['city'];
    }
    if(map['location']['address'] != null) {
      address = map['location']['address'];
    }
    return new Venue(map['id'], map['name'], category, url, distance, map['location']['lat'],
        map['location']['lng'], address, city, hereNow);
  }
}

