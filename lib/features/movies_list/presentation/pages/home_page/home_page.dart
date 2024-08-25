import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_catalog/core/constants/constants.dart';

import 'package:movie_catalog/core/theme/app_pallete.dart';
import 'package:movie_catalog/design_system/widgets/widgets.dart';
import 'package:movie_catalog/features/movies_list/presentation/cubits/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final FocusNode searchBarFocusNode = FocusNode();
  final FocusNode filterButtonFocusNode = FocusNode();
  late AnimationController filterBottomSheetController;
  late HomePageCubit _cubit;

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HomePageCubit, HomePageState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is HomePageLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomePageLoadedState) {
              final movies = state.theaterMoviesResponse.results;
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
                                child: SearchBar(
                                  onChanged: (value) => log(value),
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
                      child: SingleChildScrollView(
                        child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: movies.map(
                              (movie) {
                                final image = NetworkImage(
                                  '$imageBaseUrl${movie.posterPath}',
                                );
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: image,
                                    ),
                                    color: AppPallete.silver,
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                  ),
                                  height: 225,
                                  width: 150,
                                );
                              },
                            ).toList()),
                      ),
                    ),
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

class FilterButton extends StatefulWidget {
  final AnimationController filterBottomSheetController;
  final List<String> categoryList;
  final BoxConstraints constraints;

  const FilterButton({
    super.key,
    required this.filterBottomSheetController,
    required this.categoryList,
    required this.constraints,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isFilterActive = false;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: widget.constraints.maxHeight,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isFilterActive ? AppPallete.silver : AppPallete.gray,
          ),
          color: AppPallete.gray,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.filter_list_sharp,
          ),
          onPressed: () async {
            setState(() {
              isFilterActive = true;
            });

            await showModalBottomSheet(
              backgroundColor: AppPallete.eerieBlack,
              showDragHandle: true,
              context: context,
              builder: (context) => BottomSheet(
                backgroundColor: AppPallete.eerieBlack,
                animationController: widget.filterBottomSheetController,
                onClosing: () {},
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VSpacer(24.0),
                    Text(
                      'Filter categories:',
                      style: TextStyle(
                        color: AppPallete.silver,
                      ),
                    ),
                    const VSpacer(24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: widget.categoryList
                            .map(
                              (category) => Container(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: AppPallete.gray,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      32.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: AppPallete.silver,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const VSpacer(64.0),
                  ],
                ),
              ),
            ).then(
              (value) => setState(() {
                isFilterActive = false;
              }),
            );
          },
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final FocusNode searchBarFocusNode;
  final Function(String value) onChanged;

  const SearchBar({
    super.key,
    required this.searchBarFocusNode,
    required this.onChanged,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool hasSearchBarText = false;
  final TextEditingController searchBarTextController = TextEditingController();

  void _updateClearSearchBarButton(value) {
    setState(() => hasSearchBarText = value != '');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        8.0,
      ),
      child: Container(
        color: AppPallete.gray,
        child: TextField(
          onChanged: (value) {
            widget.onChanged(value);
            _updateClearSearchBarButton(value);
          },
          controller: searchBarTextController,
          textAlignVertical: TextAlignVertical.bottom,
          autofillHints: const [],
          cursorColor: AppPallete.silver,
          focusNode: widget.searchBarFocusNode,
          onTapOutside: (event) => widget.searchBarFocusNode.unfocus(),
          decoration: InputDecoration(
            hintText: 'Search',
            fillColor: AppPallete.gray,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppPallete.silver,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            prefixIcon: const Icon(
              Icons.search,
            ),
            suffixIcon: hasSearchBarText
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      searchBarTextController.clear();
                      widget.onChanged(searchBarTextController.text);
                      _updateClearSearchBarButton(
                        searchBarTextController.text,
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
