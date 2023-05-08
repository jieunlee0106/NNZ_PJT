import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nnz/src/config/config.dart';

class MyMapWidget extends StatefulWidget {
  const MyMapWidget({super.key});

  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(36.355291, 127.298157), zoom: 16);

  Set<Marker> markers = {};
  bool isMove = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
        ),
        FloatingActionButton.extended(
          backgroundColor: Config.yellowColor,
          onPressed: () async {
            Position position = await _determinedPosition();

            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 16),
              ),
            );
            markers.clear();

            markers.add(Marker(
                markerId: const MarkerId('CurrentLocation'),
                position: LatLng(position.latitude, position.longitude)));

            setState(() {});
          },
          label: Text(
            "현재 위치 설정",
            style: TextStyle(color: Config.blackColor),
          ),
          icon: Icon(
            Icons.room,
            color: Config.blackColor,
          ),
        ),
      ],
    );
  }

  Future<Position> _determinedPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("현재 위치를 알아낼 수 없습니다");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("거부당했습니다");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("위치 정보를 허가해주세요");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
