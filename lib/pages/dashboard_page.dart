import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/debouncer.dart';
import 'package:core/extensions.dart';
import 'package:core/utils/core_utils.dart';
import 'package:core/widgets/app_widgets.dart';
import 'package:datasource/states/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_popular/cubits/movies_cubit.dart';
import 'package:flutter_popular/models/movie.dart';
import 'package:provider/provider.dart';

import '../app_strings.dart';
import '../flavor.dart';

class DashboardPage extends HookWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*final appRepository = AppRepository();
    var apiResponse = useFuture(useMemoized(() => appRepository.fetchData(ApiCallType.get, "SearchMovie/${Keys.imdbApiKey}/inception", null))).data;
    var apiResponseModel = MovieSearchResponse.fromJson(apiResponse);*/

    final inputNode = FocusNode();
    final _debouncer = Debouncer(milliseconds: 1000);
    final flavor = Provider.of<Flavor>(context);
    final moviesCubit = BlocProvider.of<MoviesCubit>(context);
    final isSearchActive = useState(false);
    final searchText = useState('');

    if (isSearchActive.value) {
      inputNode.requestFocus();
    } else {
      searchText.value = '';
      CoreUtils.closeKeyboardForcefully();
    }

    if (searchText.value.isNotEmpty) {
      moviesCubit.searchMovies(searchText.value);
    } else {
      /// the code inside useEffect does not work unless the provided data changes, ie -> searchText.value
      useEffect(() {
        moviesCubit.getTop250Movies(false);
      }, [searchText.value]);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: isSearchActive.value
            ? TextField(
                maxLength: 25,
                onChanged: (text) => _debouncer.run(() => searchText.value = text),
                focusNode: inputNode,
                autofocus: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                decoration: const InputDecoration(
                  counterText: '',
                  hintText: 'type in movie name...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ))
            : const Text(AppStrings.imdbMovies),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => isSearchActive.value = !isSearchActive.value,
            icon: isSearchActive.value ? const Icon(Icons.cancel) : const Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
      body: BlocBuilder<MoviesCubit, DataState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Loading(loadingMessage: state.loadingMessage);
          } else if (state is ErrorState) {
            return Error(error: state.errorMessage, onRetryPressed: () => moviesCubit.getTop250Movies(true));
          } else if (state is LoadedState) {
            return MoviesListWidget(moviesList: state.data as List<Movie>);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MoviesListWidget extends StatelessWidget {
  static const imageAspectRatio = 0.73;

  final List<Movie> moviesList;

  const MoviesListWidget({Key? key, required this.moviesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: imageAspectRatio,
        ),
        itemCount: moviesList.length,
        itemBuilder: (context, index) => Card(
                child: Material(
              type: MaterialType.card,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: moviesList[index].image!,
                    placeholder: (context, url) => Image.asset('assets/movie_placeholder.png'),
                    errorWidget: (context, url, error) => Image.asset('assets/movie_placeholder.png'),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: HexColor.fromHex("#66000000")),
                      child: Text(
                        moviesList[index].title!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
