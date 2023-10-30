import 'package:dicoding_ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late GetTVSeriesWatchlistStatus usecase;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new GetTVSeriesWatchlistStatus(mockRepository);
  });

  test(
    'should return watchlist status from repository',
    () async {
      final tId = 1;
      when(mockRepository.isAddedToWatchlist(tId))
          .thenAnswer((_) async => true);

      final result = await usecase.execute(tId);

      verify(mockRepository.isAddedToWatchlist(tId));
      expect(result, true);
    },
  );
}
