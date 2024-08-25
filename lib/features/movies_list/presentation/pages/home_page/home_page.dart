import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_catalog/core/constants/constants.dart';

import 'package:movie_catalog/design_system/widgets/widgets.dart';
import 'package:movie_catalog/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:movie_catalog/features/movies_list/domain/entities/movie.dart';
import 'package:movie_catalog/features/movies_list/presentation/cubits/home_page_cubit.dart';
import 'package:movie_catalog/features/movies_list/presentation/widgets/filter_button.dart';
import 'package:movie_catalog/features/movies_list/presentation/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final FocusNode searchBarFocusNode = FocusNode();
  final FocusNode filterButtonFocusNode = FocusNode();
  final ScrollController pageScrollController = ScrollController();
  late AnimationController filterBottomSheetController;
  late AnimationController shimmerController;
  late HomePageCubit _cubit;
  List<Movie> filteredMovieList = [];
  bool isSearching = false;

  @override
  void dispose() {
    searchBarFocusNode.dispose();
    filterButtonFocusNode.dispose();
    filterBottomSheetController.dispose();
    super.dispose();
  }

  final categoryList = [
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Action',
    'Animation',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Action',
    'Animation',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Action',
    'Animation',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Action',
    'Animation',
  ];

  @override
  void initState() {
    super.initState();
    filterBottomSheetController = AnimationController(vsync: this);
    _cubit = HomePageCubit();
    _cubit.init();
    pageScrollController.addListener(() => _onScroll());
  }

  _onScroll() {
    if (pageScrollController.position.atEdge && pageScrollController.position.pixels != 0 && !isSearching) {
      _cubit.fetchMoreMovies();
    }
  }

  _updateListWithSearch(String value, List<Movie> movies) {
    {
      if (value == '') {
        setState(() {
          filteredMovieList = movies;
          isSearching = false;
        });
      } else {
        setState(() {
          isSearching = true;
          filteredMovieList = movies
              .where(
                (movie) => ('${movie.title?.toLowerCase()}').contains(value),
              )
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomePageCubit, HomePageState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is HomePageLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomePageLoadedState) {
              var movies = _cubit.currentTheaterMovies;

              movies.retainWhere(
                (movie) => movie.posterPath != "",
              );

              if (!searchBarFocusNode.hasFocus) {
                filteredMovieList = movies;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    const VSpacer(16.0),
                    SizedBox(
                      height: 50,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            children: [
                              Expanded(
                                child: SearchBarWidget(
                                  onChanged: (value) => _updateListWithSearch(value, movies),
                                  onClear: () => setState(() {
                                    isSearching = false;
                                  }),
                                  searchBarFocusNode: searchBarFocusNode,
                                ),
                              ),
                              const HSpacer(16.0),
                              FilterButton(
                                filterBottomSheetController: filterBottomSheetController,
                                categoryList: categoryList,
                                constraints: constraints,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const VSpacer(16.0),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: GridView.builder(
                          hitTestBehavior: HitTestBehavior.translucent,
                          clipBehavior: Clip.antiAlias,
                          shrinkWrap: true,
                          controller: pageScrollController,
                          itemCount: filteredMovieList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 150 / 225,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) {
                            final image = NetworkImage(
                              '$imageBaseUrl${filteredMovieList[index].posterPath}',
                            );

                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsPage(
                                    id: filteredMovieList[index].id,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: image,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                ),
                                height: 225,
                                width: 150,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const VSpacer(16.0),
                    if (state is HomePageNewMoviesLoadingState) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ]
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
