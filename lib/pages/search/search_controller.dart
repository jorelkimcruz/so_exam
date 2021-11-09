import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: implementation_imports
import 'package:string_similarity/src/extensions/string_extensions.dart';
import 'package:so_exam/models/user_manager.dart';
import 'package:so_exam/pages/search/search_view_binding.dart';

class SearchController extends GetxController with StateMixin {
  SearchController({
    required this.argument,
  });

  final SearchViewArgument argument;

  final RxList searchItems = [].obs;

  Rx<String> searchString = ''.obs;
  final userManager = UserManager();

  @override
  void onInit() {
    searchItems.value = argument.stations.list!;

    debounce(searchString, (_) => filter(),
        time: const Duration(milliseconds: 500));

    super.onInit();
  }

  void filter() {
    if (searchString.value.isNotEmpty) {
      searchItems.value = argument.stations.list!.where((station) {
        return searchString.value
                .similarityTo(station.businessName!.toLowerCase()) >=
            0.15;
      }).toList();
    } else {
      searchItems.value = argument.stations.list!;
    }
  }
}
