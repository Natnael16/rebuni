import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rebuni/features/questions/presentation/bloc/categroy_selector_bloc/category_selector_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/shimmer.dart';
import '../../../../core/utils/categories.dart';
import '../../../../core/utils/colors.dart';

class CategoriesDropDown extends StatefulWidget {
  const CategoriesDropDown({super.key, required this.categoryController});
  final TextEditingController categoryController;
  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  late List<String> selectedCategories;

  @override
  initState() {
    var blocCat =
        BlocProvider.of<CategorySelectorBloc>(context).state.categories;
    if (blocCat.isNotEmpty) {
      selectedCategories = blocCat;
    } else {
      selectedCategories = [];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategorySelectorBloc, CategorySelectorInitial>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            // Display selected categories
            Wrap(
              spacing: 8.0,
              children: [
                ...selectedCategories.map((category) {
                  return Chip(
                    side: const BorderSide(color: primaryColor),
                    label: Text(category,
                        style: Theme.of(context).textTheme.bodySmall),
                    onDeleted: () {
                      setState(() {
                        selectedCategories.remove(category);
                        BlocProvider.of<CategorySelectorBloc>(context)
                            .add(AddCategoriesEvent(selectedCategories));
                      });
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 8.0),
            // Dropdown
            Row(
              children: [
                Expanded(
                  child: TypeAheadFormField<String>(
                    direction: AxisDirection.up,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: widget.categoryController,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: black),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16),
                        filled: true,
                        fillColor: textFieldColor,
                        hintText: 'Select categories',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: blackTextColor),
                        border: InputBorder.none,
                      ),
                    ),
                    loadingBuilder: (context) {
                      return ShimmerWidget(height: 15.h);
                    },
                    suggestionsCallback: (pattern) {
                      return categories
                          .where((category) => category
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .take(4)
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          dense: true,
                          title: Text(suggestion,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w300)),
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        if (!selectedCategories.contains(suggestion)) {
                          selectedCategories.add(suggestion);
                          print(selectedCategories);
                          print(
                              "****************************************************************");
                          BlocProvider.of<CategorySelectorBloc>(context)
                              .add(AddCategoriesEvent(selectedCategories));
                        }

                        widget.categoryController.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
