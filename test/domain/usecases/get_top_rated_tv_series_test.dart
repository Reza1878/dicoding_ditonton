import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late GetTopRatedTVSeries usecase;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new GetTopRatedTVSeries(mockRepository);
  });

  test(
    'should return list of tv series',
    () async {
      when(mockRepository.getTopRatedTVSeries())
          .thenAnswer((_) async => Right([testTVSeries]));

      final result = await usecase.execute();
      final resultList = result.getOrElse(() => []);

      verify(mockRepository.getTopRatedTVSeries());
      expect(resultList, [testTVSeries]);
    },
  );
}
