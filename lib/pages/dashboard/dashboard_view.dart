import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:so_exam/components/station_tile.dart';
import 'package:so_exam/core/app.dart';
import 'package:so_exam/models/stations.dart';
import 'package:so_exam/pages/dashboard/dashboard_controller.dart';
import 'package:so_exam/components/draggable_sheet.dart';
import 'package:so_exam/pages/search/search_view_binding.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search station'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.search.value,
                  arguments: SearchViewArgument(
                    stations: controller.stations.value,
                    currentPosition: controller.currentPosition.value,
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: DragScrollSheetWithFab(
          builder: (context, scrollController) => Card(
              elevation: 20,
              child: Obx(() => controller.selectedStation.value.id != null
                  ? ListView(
                      controller: scrollController,
                      children: [
                        stationDetails(
                            context, controller.selectedStation.value)
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.stations.value.list!.isEmpty
                          ? 1
                          : controller.stations.value.list!.length + 1,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index > 0) {
                          final station =
                              controller.stations.value.list![index - 1];
                          return stationTile(station);
                        } else {
                          return headerTile(context);
                        }
                      }))),
          googleMap: Obx(() {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: controller.currentPosition.value,
              ),
              markers: Set<Marker>.of(controller.markers),
              onMapCreated: (GoogleMapController googleMapController) {
                controller.mapCompleter.complete(googleMapController);
                controller.mapController = googleMapController;
                EasyLoading.dismiss();
              },
              myLocationButtonEnabled: false,
            );
          }),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.my_location),
            onPressed: () => controller.myLocation(),
          )),
    );
  }

  Widget stationDetails(BuildContext context, Station station) {
    return Column(
      children: [
        headerTile(context),
        ListTile(
          title: Text(
            station.businessName ?? '',
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(station.address ?? ''),
              Text(
                  '${station.city ?? ''}, ${station.province ?? ''}, ${station.area ?? ''}'),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  const Icon(Icons.directions_car_filled_outlined),
                  Text(
                      '${controller.currentPosition.value.calculateDistanceWith(station.getPosition())} KM away'),
                  const Icon(Icons.timer),
                  const Text('Open 24 hours'),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget headerTile(BuildContext context) => ListTile(
        leading: controller.selectedStation.value.id != null
            ? TextButton(
                child: Text('Back to list',
                    style: Theme.of(context).textTheme.subtitle1),
                onPressed: () async {
                  await controller.hideStation();
                },
              )
            : Text('Nearby Stations',
                style: Theme.of(context).textTheme.headline6),
        trailing: Opacity(
          opacity: controller.selectedStation.value.id == null ? 0.5 : 1.0,
          child: IgnorePointer(
            ignoring: controller.selectedStation.value.id == null,
            child: TextButton(
              child: Text('Done', style: Theme.of(context).textTheme.subtitle1),
              onPressed: () async {},
            ),
          ),
        ),
      );

  Widget stationTile(Station station) {
    return StationTile(
        title: station.businessName ?? '',
        subtitle:
            '${controller.currentPosition.value.calculateDistanceWith(station.getPosition())} KM away from you',
        onChanged: (value) async {
          if (controller.mapController != null) {
            await controller.showStation(station);
          }
        });
  }
}
