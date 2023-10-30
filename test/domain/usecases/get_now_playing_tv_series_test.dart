import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late GetNowPlayingTVSeries getNowPlayingTVSeries;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    getNowPlayingTVSeries = GetNowPlayingTVSeries(mockRepository);
  });

  test(
    'should get list of tv series from the repository',
    () async {
      when(mockRepository.getNowPlayingTVSeries())
          .thenAnswer((_) async => Right([testTVSeries]));

      final result = await getNowPlayingTVSeries.execute();
      final resultList = result.getOrElse(() => []);

      verify(mockRepository.getNowPlayingTVSeries());

      expect(resultList, [testTVSeries]);
    },
  );
}
