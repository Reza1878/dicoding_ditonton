import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late GetTVSeriesRecommendations usecase;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new GetTVSeriesRecommendations(mockRepository);
  });

  test(
    'should return list of tv series',
    () async {
      final tId = 1;
      when(mockRepository.getTVSeriesRecommendations(tId))
          .thenAnswer((_) async => Right([testTVSeries]));

      final result = await usecase.execute(tId);
      final resultList = result.getOrElse(() => []);

      verify(mockRepository.getTVSeriesRecommendations(tId));
      expect(resultList, [testTVSeries]);
    },
  );
}
