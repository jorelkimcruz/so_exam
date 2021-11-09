import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:so_exam/core/services/client.dart';
import 'package:so_exam/models/stations.dart';

import 'search_controller.dart';

class SearchViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Client.dio);
    final arg = Get.arguments as SearchViewArgument;
    Get.lazyPut<SearchController>(() => SearchController(
          argument: arg,
        ));
  }
}

class SearchViewArgument {
  const SearchViewArgument({
    required this.stations,
    required this.currentPosition,
  });
  final Stations stations;
  final LatLng currentPosition;
}
