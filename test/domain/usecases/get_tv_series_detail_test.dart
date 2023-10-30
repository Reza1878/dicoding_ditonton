import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/domain/entities/genre.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVSeriesRepository mockRepository;
  late GetTVSeriesDetail usecase;

  setUp(() {
    mockRepository = new MockTVSeriesRepository();
    usecase = new GetTVSeriesDetail(mockRepository);
  });

  test(
    'should return tv series detail',
    () async {
      final tId = 1;
      final tTVSeriesDetail = TVSeriesDetail(
        posterPath: 'posterPath',
        name: 'name',
        originalName: 'originalName',
        genres: List<Genre>.from([
          {"id": 1, "name": "name"}
        ].map((e) => Genre.fromJson(e))),
        overview: 'overview',
        voteAverage: 1,
        voteCount: 1,
        id: 1,
      );

      when(mockRepository.getTVSeriesDetail(tId))
          .thenAnswer((_) async => Right(tTVSeriesDetail));

      final result = await usecase.execute(tId);

      verify(mockRepository.getTVSeriesDetail(tId));
      expect(result, Right(tTVSeriesDetail));
    },
  );
}
