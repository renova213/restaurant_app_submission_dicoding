class RestaurantTable {
  static const String tableName = 'favorite_restaurants';

  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String pictureId = 'pictureId';
  static const String city = 'city';
  static const String rating = 'rating';

  static const String createTable =
      '''
    CREATE TABLE $tableName (
      $id TEXT PRIMARY KEY,
      $name TEXT,
      $description TEXT,
      $pictureId TEXT,
      $city TEXT,
      $rating REAL
    )
  ''';
}
