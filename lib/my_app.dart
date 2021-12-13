import 'package:datasource/data_source_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popular/config/routes.dart';
import 'package:flutter_popular/config/theme.dart';
import 'package:flutter_popular/pages/dashboard_page.dart';
import 'package:flutter_popular/repositories/movies_repository.dart';

import 'cubits/movies_cubit.dart';

class MyApp extends StatelessWidget {
  MoviesCubit? moviesCubit;

  MyApp({Key? key, this.moviesCubit}) : super(key: key) {
    DataSourceConfig.initDataSource("https://imdb-api.com/en/API/");

    moviesCubit ??= MoviesCubit(repository: MoviesRepository());
  }

  BlocProvider<MoviesCubit> getDashboardPage() {
    return BlocProvider<MoviesCubit>(
      create: (context) => moviesCubit!,
      child: const DashboardPage(),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.of(context),
      routes: <String, WidgetBuilder>{
        AppRoutes.home: (context) => getDashboardPage(),

        /// can change the route
        AppRoutes.splash: (context) => getDashboardPage(),
        AppRoutes.dashboard: (context) => getDashboardPage()
      },
    );
  }
}
