import 'package:fuiopia/data/models/location_model.dart';
import 'package:equatable/equatable.dart';

/// Delivery address model
class DeliveryAddressModel extends Equatable {
  final String id;

  final String receiverName;

  final String phoneNumber;

  final LocationModel city;

  final LocationModel district;

  final LocationModel ward;

  final String detailAddress;

  final bool isDefault;

  /// Constructor
  const DeliveryAddressModel({
    required this.id,
    required this.receiverName,
    required this.phoneNumber,
    required this.isDefault,
    required this.city,
    required this.district,
    required this.ward,
    required this.detailAddress,
  });

  /// Json data from server turns into model data
  static DeliveryAddressModel fromMap(Map<String, dynamic> data) {
    var city = const LocationModel();
    var district = const LocationModel();
    var ward = const LocationModel();

    if (data["city"] != null) {
      city = LocationModel.fromMap(data["city"]);
    }

    if (data["district"] != null) {
      district = LocationModel.fromMap(data["district"]);
    }

    if (data["ward"] != null) {
      ward = LocationModel.fromMap(data["ward"]);
    }
    return DeliveryAddressModel(
      id: data["id"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      receiverName: data["receiverName"] ?? "",
      city: city,
      district: district,
      ward: ward,
      detailAddress: data["detailAddress"] ?? "",
      isDefault: data["isDefault"] ?? false,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "phoneNumber": phoneNumber,
      "receiverName": receiverName,
      "city": city.toMap(),
      "district": district.toMap(),
      "ward": ward.toMap(),
      "detailAddress": detailAddress,
      "isDefault": isDefault,
    };
  }

  /// Clone and update
  DeliveryAddressModel cloneWith({
    id,
    receiverName,
    phoneNumber,
    city,
    district,
    ward,
    detailAddress,
    isDefault,
  }) {
    return DeliveryAddressModel(
      id: id ?? this.id,
      receiverName: receiverName ?? this.receiverName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      detailAddress: detailAddress ?? this.detailAddress,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() {
    return "$detailAddress, ${ward.name}, ${district.name}, ${city.name}";
  }

  @override
  List<Object> get props => [
        id,
        receiverName,
        phoneNumber,
        city,
        district,
        ward,
        detailAddress,
        isDefault,
      ];
}
