import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:dicoding_ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late TvSeriesDetailBloc tvSeriesDetailBloc;

  setUp(() {
    mockGetTVSeriesDetail = new MockGetTVSeriesDetail();
    tvSeriesDetailBloc = new TvSeriesDetailBloc(mockGetTVSeriesDetail);
  });

  group('TVSeriesDetailBloc', () {
    final tId = 1;
    final testTVSeriesDetail = TVSeriesDetailResponse.fromJson(
      testTVSeriesDetailMap,
    );
    test('initial state should be TVSeriesDetailInitial', () {
      expect(tvSeriesDetailBloc.state, TvSeriesDetailInitial());
    });

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId)).thenAnswer((realInvocation) =>
            Future.value(Left(ServerFailure('Server Failure'))));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVSeriesDetail(tId)),
      expect: () => [
        TVSeriesDetailLoading(),
        TVSeriesDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId)).thenAnswer(
          (realInvocation) => Future.value(
            Right(
              testTVSeriesDetail.toEntity(),
            ),
          ),
        );
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVSeriesDetail(tId)),
      expect: () => [
        TVSeriesDetailLoading(),
        TVSeriesDetailLoaded(testTVSeriesDetail.toEntity()),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
      },
    );
  });
}
