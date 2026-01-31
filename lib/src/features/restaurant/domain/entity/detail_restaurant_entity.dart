import 'package:equatable/equatable.dart';

class DetailRestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<DetailRestaurantCategoryEntity> categories;
  final DetailRestaurantMenuEntity menus;
  final double rating;
  final List<DetailRestaurantCustomerReviewEntity> customerReviews;

  const DetailRestaurantEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    city,
    address,
    pictureId,
    categories,
    menus,
    rating,
    customerReviews,
  ];
}

class DetailRestaurantCategoryEntity extends Equatable {
  final String name;

  const DetailRestaurantCategoryEntity({required this.name});

  @override
  List<Object?> get props => [name];
}

class DetailRestaurantMenuEntity extends Equatable {
  final List<DetailRestaurantMenuItemEntity> foods;
  final List<DetailRestaurantMenuItemEntity> drinks;

  const DetailRestaurantMenuEntity({required this.foods, required this.drinks});

  @override
  List<Object?> get props => [foods, drinks];
}

class DetailRestaurantMenuItemEntity extends Equatable {
  final String name;

  const DetailRestaurantMenuItemEntity({required this.name});

  @override
  List<Object?> get props => [name];
}

class DetailRestaurantCustomerReviewEntity extends Equatable {
  final String name;
  final String review;
  final String date;

  const DetailRestaurantCustomerReviewEntity({
    required this.name,
    required this.review,
    required this.date,
  });

  @override
  List<Object?> get props => [name, review, date];
}
