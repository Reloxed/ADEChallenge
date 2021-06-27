/* Class that defines a detailed venue when the user selects one of the searched venues.*/
class DetailedVenue {
  late String id;
  late String name;
  late String category;
  late String iconUrl;
  late double distance;
  late double latitude;
  late double longitude;
  late String address;

  // Details
  late String city;
  late String formattedPhone;
  late String website;
  late int hereNow;
  late bool? isOpen;
  late List<TimeFrame> timeframes;

  DetailedVenue(
      String id,
      String name,
      String category,
      String iconUrl,
      double distance,
      double latitude,
      double longitude,
      String address,
      String city,
      String formattedPhone,
      String website,
      int hereNow,
      bool? isOpen,
      List<TimeFrame> timeframes) {
    this.id = id;
    this.name = name;
    this.category = category;
    this.iconUrl = iconUrl;
    this.distance = distance;
    this.latitude = latitude;
    this.longitude = longitude;
    this.address = address;
    // Details
    this.city = city;
    this.formattedPhone = formattedPhone;
    this.website = website;
    this.hereNow = hereNow;
    this.isOpen = isOpen;
    this.timeframes = timeframes;
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
    bool? isOpen;
    List<TimeFrame> timeframes = [];
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
    }
    if (map['hereNow']['count'] != null) {
      hereNow = map['hereNow']['count'];
    }
    if (map['hours'] != null) {
      if(map['hours']['isOpen'] != null)
        isOpen = map['hours']['isOpen'];
      if (map['hours']['timeFrames'] != null) {
        for(int i = 0; i < map['hours']['timeFrames'].length; i++) {
          String days = map['hours']['timeFrames'][i]['days'];
          String renderedTime = map['hours']['timeFrames'][i]['open']['renderedTime'];
          TimeFrame timeFrame = new TimeFrame(days, renderedTime);
          timeframes.add(timeFrame);
        }
      }
    }
    return new DetailedVenue(map['id'], map['name'], category, url, distance, map['location']['lat'],
        map['location']['lng'], address, city, formattedPhone, website, hereNow, isOpen, timeframes);
  }
}

class TimeFrame {
  late String days;
  late String renderedTime;

  TimeFrame(String days, String renderedTime) {
    this.days = days;
    this.renderedTime = renderedTime;
  }
}
