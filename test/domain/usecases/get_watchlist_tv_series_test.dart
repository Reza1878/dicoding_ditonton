import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockRepository;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new GetWatchlistTVSeries(mockRepository);
  });

  test(
    'should get list of tv series from the repository',
    () async {
      when(mockRepository.getWatchlistTVSeries())
          .thenAnswer((_) async => Right([testTVSeries]));

      final result = await usecase.execute();
      final resultList = result.getOrElse(() => []);

      expect(resultList, equals([testTVSeries]));
    },
  );
}
