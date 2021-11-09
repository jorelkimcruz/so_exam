import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:so_exam/components/station_tile.dart';
import 'package:so_exam/pages/dashboard/dashboard_controller.dart';
import 'package:so_exam/pages/search/search_controller.dart';
import 'package:so_exam/models/stations.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search station'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              child: searchView(context)),
          Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: controller.searchItems.length,
                  itemBuilder: (context, index) {
                    final Station station = controller.searchItems[index];
                    return StationTile(
                      title: station.businessName ?? '',
                      subtitle:
                          '${controller.argument.currentPosition.calculateDistanceWith(station.getPosition())} KM away from you',
                      onChanged: (val) async {
                        await DashboardController.to.showStation(station);
                        Get.back();
                      },
                    );
                  })))
        ],
      ),
    );
  }

  Widget searchView(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          onChanged: (str) {
            // didnt use textfield to add debounce on search
            controller.searchString.value = str;
          },
          decoration: InputDecoration(
            prefix: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Search station',
            helperMaxLines: 3,
            labelStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
