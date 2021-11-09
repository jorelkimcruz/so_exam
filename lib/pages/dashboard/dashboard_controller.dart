import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:so_exam/core/services/user_service.dart';
import 'package:so_exam/models/stations.dart';

class DashboardController extends GetxController with StateMixin {
  DashboardController({
    required this.userservice,
  });

  UserServiceProtocol userservice;
  Completer<GoogleMapController> mapCompleter = Completer();
  GoogleMapController? mapController;
  final Rx<Stations> stations = Stations(list: []).obs;
  Rx<LatLng> currentPosition = const LatLng(0, 0).obs;
  RxList<Marker> markers = <Marker>[].obs;

  Rx<Station> selectedStation = Station().obs;

  static final DashboardController to = Get.find<DashboardController>();

  @override
  void onInit() {
    determinePosition().then((value) async {
      await _populateStations(value);
    });

    super.onInit();
  }

  Future showStation(Station station) async {
    await mapController!.moveCamera(
      CameraUpdate.newLatLng(
        station.getPosition(),
      ),
    );
    selectedStation.value = station;
    markers.add(Marker(
      markerId: MarkerId(station.dealerId!.toString()),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: station.businessName ?? ''),
      position: station.getPosition(),
    ));
  }

  Future hideStation() async {
    markers.clear();
    await mapController!.moveCamera(
      CameraUpdate.newLatLng(
        currentPosition.value,
      ),
    );
    selectedStation.value = Station();
  }

  Future myLocation() async {
    final value = await determinePosition();
    _populateStations(value);
  }

  Future _populateStations(Position position) async {
    currentPosition.value = LatLng(position.latitude, position.longitude);
    currentPosition.update(currentPosition);
    final controller = await mapCompleter.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPosition.value, zoom: 17)));
    final value = await userservice.getStationList();

    value.list!.sort((Station a, Station b) => currentPosition.value
        .calculateDistanceWith(a.getPosition())
        .compareTo(
            currentPosition.value.calculateDistanceWith(b.getPosition())));

    stations.value = value;
    markers.clear();
    selectedStation.value = Station();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
