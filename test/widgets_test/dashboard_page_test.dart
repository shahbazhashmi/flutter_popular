import 'package:core/widgets/app_widgets.dart';
import 'package:datasource/states/data_state.dart';
import 'package:flutter_popular/cubits/movies_cubit.dart';
import 'package:flutter_popular/models/movie.dart';
import 'package:flutter_popular/pages/dashboard_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';
import '../test_utils.dart';

void main() {
  late MoviesCubit moviesCubit;

  setUp(() {
    moviesCubit = MockMoviesCubit();
  });

  testWidgets('Test to verify getTop250Movies() shows loader', (WidgetTester tester) async {
    when(() => moviesCubit.state).thenReturn(LoadingState('test message'));

    await tester.pumpWidget(TestUtils.getApp(moviesCubit));

    await tester.pump(Duration.zero);

    expect(find.byType(Loading), findsOneWidget);
  });

  testWidgets('Test to verify getTop250Movies() shows data', (WidgetTester tester) async {
    when(() => moviesCubit.state).thenReturn(LoadedState('data loaded', [
      Movie(
          title: 'Avatar',
          description: 'mock movie',
          image:
              'https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg'),
      Movie(
          title: 'Inception',
          description: 'mock movie',
          image:
              'https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg'),
    ]));

    await tester.pumpWidget(TestUtils.getApp(moviesCubit));

    await tester.pump(Duration.zero);

    expect(find.byType(MoviesListWidget), findsOneWidget);
  });

  testWidgets('Test to verify getTop250Movies() shows error', (WidgetTester tester) async {
    when(() => moviesCubit.state).thenReturn(ErrorState('test error'));

    await tester.pumpWidget(TestUtils.getApp(moviesCubit));

    await tester.pump(Duration.zero);

    expect(find.byType(Error), findsOneWidget);
  });
}
