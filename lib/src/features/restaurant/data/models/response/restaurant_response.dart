import 'package:equatable/equatable.dart';

import '../../../domain/domain.dart';

class RestaurantResponse extends Equatable {
  final List<RestaurantItemResponse> restaurantList;

  const RestaurantResponse({required this.restaurantList});

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantResponse(
      restaurantList: json['restaurants'] != null
          ? (json['restaurants'] as List)
                .map((e) => RestaurantItemResponse.fromJson(e))
                .toList()
          : [],
    );
  }

  RestaurantEntity toEntity() {
    return RestaurantEntity(
      restaurantList: restaurantList.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'restaurants': restaurantList.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object?> get props => [restaurantList];
}

class RestaurantItemResponse extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const RestaurantItemResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantItemResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantItemResponse(
      id: json['id'] ?? "",
      name: json['name'] ?? "-",
      description: json['description'] ?? "-",
      pictureId: json['pictureId'] != null
          ? "https://restaurant-api.dicoding.dev/images/medium/${json['pictureId']}"
          : "",
      city: json['city'] ?? "-",
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
    );
  }

  RestaurantItemEntity toEntity() {
    return RestaurantItemEntity(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      rating: rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  @override
  List<Object?> get props => [id, name, description, pictureId, city, rating];
}
