import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/src/core/core.dart';
import 'package:restaurant_app/src/features/restaurant/domain/usecase/params/params.dart';
import 'package:restaurant_app/src/features/restaurant/restaurant.dart';

import 'add_review_restaurant_provider_test.mocks.dart';

@GenerateMocks([PostAddReviewRestaurantUsecase])
void main() {
  late MockPostAddReviewRestaurantUsecase mockUsecase;
  late AddReviewRestaurantProvider provider;

  setUp(() {
    mockUsecase = MockPostAddReviewRestaurantUsecase();
    provider = AddReviewRestaurantProvider(mockUsecase);
  });

  final param = AddRestaurantReviewParam(
    id: 'rqdv5juczeskfw1e867',
    name: 'Rizco',
    review: 'Mantap!',
  );

  final reviews = [
    DetailRestaurantCustomerReviewEntity(
      name: 'Rizco',
      review: 'Mantap!',
      date: '2026-02-08',
    ),
  ];

  group('AddReviewRestaurantProvider', () {
    test('initial state should be AppState.initial', () {
      expect(provider.addReviewState, AppState.initial);
      expect(provider.errorMessage, isEmpty);
    });

    test('SUCCESS: loading → loaded and return reviews', () async {
      when(mockUsecase.call(param)).thenAnswer((_) async => Right(reviews));

      expect(provider.addReviewState, AppState.initial);

      provider.changeAppState(AppState.loading);

      expect(provider.addReviewState, AppState.loading);

      final result = await provider.addReview(param);

      expect(provider.addReviewState, AppState.loaded);
      expect(provider.errorMessage, isEmpty);
      expect(result, reviews);

      verify(mockUsecase.call(param)).called(1);
      verifyNoMoreInteractions(mockUsecase);
    });

    test('ERROR: loading → error and return empty list', () async {
      final failure = AppError(
        message: 'Server error',
        originalError: Exception('500'),
      );

      when(mockUsecase.call(param)).thenAnswer((_) async => Left(failure));

      provider.changeAppState(AppState.loading);
      expect(provider.addReviewState, AppState.loading);

      final result = await provider.addReview(param);

      // assert
      expect(provider.addReviewState, AppState.error);
      expect(provider.errorMessage, 'Server error');
      expect(result, isEmpty);

      verify(mockUsecase.call(param)).called(1);
      verifyNoMoreInteractions(mockUsecase);
    });
  });
}
