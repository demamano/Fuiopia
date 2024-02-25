import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String id;
  final String name;

  const LocationModel({this.id = "", this.name = ""});

  static LocationModel fromMap(Map<String, dynamic> data) {
    return LocationModel(
      id: data["code"] ?? "",
      name: data["name"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "code": id,
      "name": name,
    };
  }

  @override
  List<Object> get props => [id, name];
}
