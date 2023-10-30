import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late SearchTVSeries usecase;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new SearchTVSeries(mockRepository);
  });

  test(
    'should return list of tv series from repository',
    () async {
      final tQuery = "test";

      when(mockRepository.searchTVSeries(tQuery))
          .thenAnswer((_) async => Right([testTVSeries]));

      final result = await usecase.execute(tQuery);
      final resultList = result.getOrElse(() => []);

      verify(mockRepository.searchTVSeries(tQuery));
      expect(resultList, [testTVSeries]);
    },
  );
}
