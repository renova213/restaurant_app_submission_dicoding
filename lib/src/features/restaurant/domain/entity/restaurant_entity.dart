import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final List<RestaurantItemEntity> restaurantList;

  const RestaurantEntity({required this.restaurantList});

  @override
  List<Object?> get props => [restaurantList];
}

class RestaurantItemEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const RestaurantItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, name, description, pictureId, city, rating];
}
