import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popular/config/config.dart';
import 'package:flutter_popular/providers/favourites_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:core/widgets/app_widgets.dart';

import '../providers/favourites_provider.dart';

class FavouritesPage extends HookConsumerWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMoviesMap =
        (ref.watch(favouritesProvider) as FavouritesState).favouriteMovies;
    final favouriteMovies = favouriteMoviesMap.entries.map((entry) => entry.value).toList();
    final favouriteProvider = ref.watch(favouritesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Movies'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: favouriteMovies.isEmpty ? const Error(
          error: 'Favourite Movies not found'
      ) : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: Config.imageAspectRatio,
          ),
          itemCount: favouriteMovies.length,
          itemBuilder: (context, index) => Card(
              child: Material(
                type: MaterialType.card,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: favouriteMovies[index].image!,
                      placeholder: (context, url) =>
                          Image.asset('assets/movie_placeholder.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/movie_placeholder.png'),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(6),
                        decoration:
                        BoxDecoration(color: HexColor.fromHex("#66000000")),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                                  favouriteMovies[index].title!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 3,
                                )),
                            InkWell(
                              onTap: () => favouriteProvider
                                  .addRemoveMovie(favouriteMovies[index]),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
