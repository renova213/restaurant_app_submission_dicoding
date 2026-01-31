import 'package:equatable/equatable.dart';

import '../../../domain/domain.dart';

class DetailRestaurantResponse extends Equatable {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<DetailRestaurantCategoryResponse> categories;
  final DetailRestaurantMenuResponse menus;
  final double rating;
  final List<DetailRestaurantCustomerReviewResponse> customerReviews;

  const DetailRestaurantResponse({
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

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> detailRestaurantJson = json['restaurant'];

    return DetailRestaurantResponse(
      id: detailRestaurantJson['id'] ?? "",
      name: detailRestaurantJson['name'] ?? "-",
      description: detailRestaurantJson['description'] ?? "-",
      city: detailRestaurantJson['city'] ?? "-",
      address: detailRestaurantJson['address'] ?? "-",
      pictureId: detailRestaurantJson['pictureId'] != null
          ? "https://restaurant-api.dicoding.dev/images/large/${detailRestaurantJson['pictureId']}"
          : "",
      categories: detailRestaurantJson['categories'] != null
          ? (detailRestaurantJson['categories'] as List)
                .map((e) => DetailRestaurantCategoryResponse.fromJson(e))
                .toList()
          : [],
      menus: DetailRestaurantMenuResponse.fromJson(
        detailRestaurantJson['menus'],
      ),
      rating: detailRestaurantJson['rating'] != null
          ? (detailRestaurantJson['rating'] as num).toDouble()
          : 0.0,
      customerReviews: detailRestaurantJson['customerReviews'] != null
          ? (detailRestaurantJson['customerReviews'] as List)
                .map((e) => DetailRestaurantCustomerReviewResponse.fromJson(e))
                .toList()
          : [],
    );
  }

  DetailRestaurantEntity toEntity() {
    return DetailRestaurantEntity(
      id: id,
      name: name,
      description: description,
      city: city,
      address: address,
      pictureId: pictureId,
      categories: categories.map((e) => e.toEntity()).toList(),
      menus: menus.toEntity(),
      rating: rating,
      customerReviews: customerReviews.map((e) => e.toEntity()).toList(),
    );
  }

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

class DetailRestaurantCategoryResponse extends Equatable {
  final String name;

  const DetailRestaurantCategoryResponse({required this.name});

  factory DetailRestaurantCategoryResponse.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantCategoryResponse(name: json['name'] ?? "-");
  }

  DetailRestaurantCategoryEntity toEntity() {
    return DetailRestaurantCategoryEntity(name: name);
  }

  @override
  List<Object?> get props => [name];
}

class DetailRestaurantMenuResponse extends Equatable {
  final List<DetailRestaurantMenuItemResponse> foods;
  final List<DetailRestaurantMenuItemResponse> drinks;

  const DetailRestaurantMenuResponse({
    required this.foods,
    required this.drinks,
  });

  factory DetailRestaurantMenuResponse.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantMenuResponse(
      foods: json['foods'] != null
          ? (json['foods'] as List)
                .map((e) => DetailRestaurantMenuItemResponse.fromJson(e))
                .toList()
          : [],
      drinks: json['drinks'] != null
          ? (json['drinks'] as List)
                .map((e) => DetailRestaurantMenuItemResponse.fromJson(e))
                .toList()
          : [],
    );
  }

  DetailRestaurantMenuEntity toEntity() {
    return DetailRestaurantMenuEntity(
      foods: foods.map((e) => e.toEntity()).toList(),
      drinks: drinks.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [foods, drinks];
}

class DetailRestaurantMenuItemResponse extends Equatable {
  final String name;

  const DetailRestaurantMenuItemResponse({required this.name});

  factory DetailRestaurantMenuItemResponse.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantMenuItemResponse(name: json['name'] ?? "-");
  }

  DetailRestaurantMenuItemEntity toEntity() {
    return DetailRestaurantMenuItemEntity(name: name);
  }

  @override
  List<Object?> get props => [name];
}

class DetailRestaurantCustomerReviewResponse extends Equatable {
  final String name;
  final String review;
  final String date;

  const DetailRestaurantCustomerReviewResponse({
    required this.name,
    required this.review,
    required this.date,
  });

  factory DetailRestaurantCustomerReviewResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return DetailRestaurantCustomerReviewResponse(
      name: json['name'] ?? "-",
      review: json['review'] ?? "-",
      date: json['date'] ?? "-",
    );
  }

  DetailRestaurantCustomerReviewEntity toEntity() {
    return DetailRestaurantCustomerReviewEntity(
      name: name,
      review: review,
      date: date,
    );
  }

  @override
  List<Object?> get props => [name, review, date];
}
