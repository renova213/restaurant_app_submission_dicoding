import 'package:sqflite/sqflite.dart';

import '../../../../../core/core.dart';
import '../../models/response/response.dart';
import 'restaurant_local_datasource.dart';

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final AppDatabase database;
  RestaurantLocalDataSourceImpl(this.database);

  @override
  Future<void> insertFavorite(RestaurantItemResponse restaurant) async {
    final db = await database.database;

    await db.insert(
      RestaurantTable.tableName,
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(String id) async {
    final db = await database.database;

    await db.delete(
      RestaurantTable.tableName,
      where: '${RestaurantTable.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<RestaurantItemResponse>> getFavorites() async {
    final db = await database.database;

    final result = await db.query(RestaurantTable.tableName);

    return result
        .map(
          (json) => RestaurantItemResponse(
            id: json['id'] as String,
            name: json['name'] as String,
            description: json['description'] as String,
            pictureId: json['pictureId'] as String,
            city: json['city'] as String,
            rating: (json['rating'] as num).toDouble(),
          ),
        )
        .toList();
  }

  @override
  Future<bool> isFavorite(String id) async {
    final db = await database.database;

    final result = await db.query(
      RestaurantTable.tableName,
      where: '${RestaurantTable.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
