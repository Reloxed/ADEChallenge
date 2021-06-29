import 'dart:async';

import 'package:adechallenge/database/inserts.dart';

import '../models/providers/detailed_venue_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                _map(provider),
                Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        _title(provider),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            _icon(provider.detailedVenue.iconUrl),
                            _onIconRight(
                                provider.detailedVenue.category,
                                provider.detailedVenue.distance.toString(),
                                provider.detailedVenue.address,
                                provider.detailedVenue.city,
                                provider.detailedVenue.formattedPhone)
                          ]),
                        ),
                        provider.detailedVenue.website.isNotEmpty
                            ? _rest(provider.detailedVenue.website, provider.detailedVenue.isOpen,
                                provider.detailedVenue.hereNow)
                            : Container()
                      ],
                    ))
              ],
            ),
    );
  }

  Widget _map(var provider) {
    List<Marker> markers = [];
    MarkerId markerId = new MarkerId(provider.detailedVenue.name);
    markers = [
      new Marker(
        markerId: markerId,
        position: new LatLng(provider.detailedVenue.latitude, provider.detailedVenue.longitude),
      )
    ];
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: GoogleMap(
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: true,
            myLocationEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: new CameraPosition(
                target: new LatLng(provider.detailedVenue.latitude, provider.detailedVenue.longitude), zoom: 14),
            markers: markers.toSet()));
  }

  Widget _title(var provider) {
    Color _starColor = Colors.grey;
    if (provider.isFavorite) {
      _starColor = Colors.yellow.shade800;
    } else {
      _starColor = Colors.grey;
    }

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(provider.detailedVenue.name, style: Theme.of(context).textTheme.headline5),
            IconButton(
              icon: Icon(Icons.star, color: _starColor),
              onPressed: () async {
                if (_starColor == Colors.grey) {
                  await saveFavorites(provider.detailedVenue);
                  provider.setFavorite(true);
                } else {
                  await deleteFavorites(provider.detailedVenue.id);
                  provider.setFavorite(false);
                }
                provider.getFavoriteListFromDatabase();
              },
            )
          ],
        ));
  }

  Widget _icon(String iconUrl) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Image.network(iconUrl),
    );
  }

  Widget _onIconRight(String category, String distance, String address, String city, String formattedPhone) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          distance != "-1.0" ? Text(distance + " minutes far") : Container(),
          address.isNotEmpty
              ? city.isNotEmpty
                  ? Text(
                      address + ", " + city,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  : Text(
                      address,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
              : Container(),
          formattedPhone.isNotEmpty
              ? Row(
                  children: [Icon(Icons.phone), Text(" " + formattedPhone)],
                )
              : Container()
        ],
      ),
    );
  }

  Widget _rest(String url, bool? isOpen, int hereNow) {
    return Container(
        margin: EdgeInsets.only(top: 30.0, left: 50.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.language),
                InkWell(onTap: () => launch(url), child: Text(" Más información/Sitio web"))
              ],
            ),
            isOpen != null
                ? Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: isOpen
                        ? Row(children: [Icon(Icons.lock_open), Text(" Está abierto")])
                        : Row(
                            children: [Icon(Icons.lock), Text(" Está cerrado")],
                          ))
                : Container(),
            hereNow != -1
                ? Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.group),
                        hereNow > 0
                            ? Text(" Hay " + hereNow.toString() + " personas ahora mismo.")
                            : Text(" No hay nadie ahora mismo")
                      ],
                    ),
                  )
                : Container()
          ],
        ));
  }
}
