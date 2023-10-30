import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late SaveTVSeriesWatchlist usecase;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new SaveTVSeriesWatchlist(mockRepository);
  });

  test(
    'should return success message',
    () async {
      final testTVSeriesDetail = TVSeriesDetailResponse.fromJson(
        testTVSeriesDetailMap,
      ).toEntity();

      when(mockRepository.saveWatchlist(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));

      final result = await usecase.execute(testTVSeriesDetail);

      verify(mockRepository.saveWatchlist(testTVSeriesDetail));
      expect(result, Right('Added to Watchlist'));
    },
  );
}
