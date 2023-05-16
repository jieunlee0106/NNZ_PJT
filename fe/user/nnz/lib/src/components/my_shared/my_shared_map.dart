import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/myshared_info_controller.dart';

class MyMapWidget extends StatefulWidget {
  const MyMapWidget(
      {super.key, this.userLat, this.userLong, required this.isUser});
  final double? userLong;
  final double? userLat;
  final String isUser;

  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

@override
void onReady() {}

class _MyMapWidgetState extends State<MyMapWidget> {
  late GoogleMapController googleMapController;
  var infoFormController = Get.put(MysharedInfoController());

  static CameraPosition initialCameraPosition(double userLat, double userLong) {
    return CameraPosition(target: LatLng(userLat, userLong), zoom: 16);
  }

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
            initialCameraPosition: initialCameraPosition(
                (widget.userLat == null ? (widget.userLat!) : (36.1)),
                widget.userLong == null ? (widget.userLong!) : (127.1)),
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.extended(
              backgroundColor: Config.yellowColor,
              onPressed: () async {
                Position position = await _determinedPosition();
                infoFormController.userlatController.text =
                    position.latitude.toString();
                infoFormController.userlongController.text =
                    position.longitude.toString();

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
                widget.isUser,
                style: TextStyle(color: Config.blackColor),
              ),
              icon: Icon(
                Icons.room,
                color: Config.blackColor,
              ),
            ),
            FloatingActionButton.extended(
              backgroundColor: Config.yellowColor,
              onPressed: () async {
                Position position = await _determinedPosition();
                infoFormController.userlatController.text =
                    position.latitude.toString();
                infoFormController.userlongController.text =
                    position.longitude.toString();

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
                    position: LatLng(widget.userLat!, widget.userLong!)));

                setState(() {});
              },
              label: Text(
                "나눔 위치 확인",
                style: TextStyle(color: Config.blackColor),
              ),
              icon: Icon(
                Icons.room,
                color: Config.blackColor,
              ),
            ),
          ],
        )
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
