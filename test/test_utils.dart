import 'package:flutter_popular/cubits/movies_cubit.dart';
import 'package:flutter_popular/flavor.dart';
import 'package:flutter_popular/my_app.dart';
import 'package:provider/provider.dart';

import 'test_config.dart';

class TestUtils {
  static Provider<Flavor> getApp(MoviesCubit? moviesCubit) => TestConfig.testProductFlavor == Flavor.prod
      ? Provider<Flavor>.value(value: Flavor.staging, child: MyApp(moviesCubit: moviesCubit))
      : Provider<Flavor>.value(value: Flavor.prod, child: MyApp(moviesCubit: moviesCubit));
}
