class AddRestaurantReviewParam {
  final String id;
  final String name;
  final String review;

  AddRestaurantReviewParam({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'review': review};
}
