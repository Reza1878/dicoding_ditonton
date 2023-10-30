import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late RemoveTVSeriesWatchlist usecase;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new RemoveTVSeriesWatchlist(mockRepository);
  });

  test(
    'should return success message',
    () async {
      final testTVSeriesDetail = TVSeriesDetailResponse.fromJson(
        testTVSeriesDetailMap,
      ).toEntity();

      when(mockRepository.removeWatchlist(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));

      final result = await usecase.execute(testTVSeriesDetail);

      verify(mockRepository.removeWatchlist(testTVSeriesDetail));
      expect(result, Right('Removed from Watchlist'));
    },
  );
}
