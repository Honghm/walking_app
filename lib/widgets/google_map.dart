import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/provider/home_provider.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(13.7315172, 108.0598776),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    return Container(
      height: 350,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: false,
            mapType: MapType.normal,
            polylines: home.polylines,
            initialCameraPosition: initialLocation,
            markers: Set.of((home.marker != null) ? [home.marker] : []),
            onMapCreated: (GoogleMapController controller) {
              home.controller = controller;
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(300, 260, 10, 0),
            child: FloatingActionButton(
                child: Icon(Icons.location_searching),
                onPressed: () {
                  home.getCurrentLocation(context: context, Case: 2);
                }),
          ),
        ],
      ),
    );
  }
}
