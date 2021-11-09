import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Stations {
  List<Station>? list;

  Stations({this.list});

  Stations.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      list = <Station>[];
      json['data'].forEach((v) {
        list?.add(Station.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> tempData = <String, dynamic>{};

    tempData['data'] = list?.map((v) => v.toJson()).toList();

    return tempData;
  }
}

class Station {
  int? id;
  String? code;
  String? mobileNum;
  String? area;
  String? province;
  String? city;
  String? name;
  String? businessName;
  String? address;
  String? lat;
  String? lng;
  String? type;
  int? depotId;
  int? dealerId;
  String? createdAt;
  String? updatedAt;

  RxBool selected = false.obs;

  Station(
      {this.id,
      this.code,
      this.mobileNum,
      this.area,
      this.province,
      this.city,
      this.name,
      this.businessName,
      this.address,
      this.lat,
      this.lng,
      this.type,
      this.depotId,
      this.dealerId,
      this.createdAt,
      this.updatedAt});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    mobileNum = json['mobileNum'];
    area = json['area'];
    province = json['province'];
    city = json['city'];
    name = json['name'];
    businessName = json['businessName'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    type = json['type'];
    depotId = json['depotId'];
    dealerId = json['dealerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['mobileNum'] = mobileNum;
    data['area'] = area;
    data['province'] = province;
    data['city'] = city;
    data['name'] = name;
    data['businessName'] = businessName;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['type'] = type;
    data['depotId'] = depotId;
    data['dealerId'] = dealerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  LatLng getPosition() =>
      LatLng(double.tryParse(lat!) ?? 0, double.tryParse(lng!) ?? 0);
}

extension LatLngExtension on LatLng {
  double calculateDistanceWith(LatLng end) {
    double distanceInKiloMeters = Geolocator.distanceBetween(
            latitude, longitude, end.latitude, end.longitude) /
        1000;

    return double.tryParse(distanceInKiloMeters.toStringAsFixed(2)) ?? 0;
  }
}
