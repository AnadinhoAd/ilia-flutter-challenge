import 'dart:developer';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final FocusNode searchBarFocusNode = FocusNode();
  final FocusNode filterButtonFocusNode = FocusNode();
  late AnimationController filterBottomSheetController;

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.eerieBlack,
        body: Padding(
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
                          filterBottomSheetController:
                              filterBottomSheetController,
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
                    children: List.generate(
                      25,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.silver,
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        height: 220,
                        width: 170,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            color: isFilterActive ? AppColors.silver : AppColors.gray,
          ),
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: IconButton(
          onPressed: () async {
            setState(() {
              isFilterActive = true;
            });

            await showModalBottomSheet(
              backgroundColor: AppColors.eerieBlack,
              showDragHandle: true,
              context: context,
              builder: (context) => BottomSheet(
                backgroundColor: AppColors.eerieBlack,
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
                        color: AppColors.silver,
                      ),
                    ),
                    const VSpacer(24.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: widget.categoryList
                          .map(
                            (category) => Container(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    32.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: AppColors.silver,
                                ),
                              ),
                            ),
                          )
                          .toList(),
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
          icon: const Icon(
            Icons.filter_list_sharp,
          ),
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
        color: AppColors.gray,
        child: TextField(
          onChanged: (value) {
            widget.onChanged(value);
            _updateClearSearchBarButton(value);
          },
          controller: searchBarTextController,
          textAlignVertical: TextAlignVertical.bottom,
          autofillHints: const [],
          cursorColor: AppColors.silver,
          focusNode: widget.searchBarFocusNode,
          onTapOutside: (event) => widget.searchBarFocusNode.unfocus(),
          decoration: InputDecoration(
            hintText: 'Search',
            fillColor: AppColors.gray,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.silver,
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
