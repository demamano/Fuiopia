import 'package:equatable/equatable.dart';

/// CategoryModel model
class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  /// Json data from server turns into model data
  static CategoryModel fromMap(String id, Map<String, dynamic> data) {
    return CategoryModel(
      id: data["id"] ?? "",
      name: data["name"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
    };
  }

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [id];
}
