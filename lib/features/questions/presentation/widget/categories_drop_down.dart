import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rebuni/features/questions/presentation/bloc/categroy_selector_bloc/category_selector_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/shimmer.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/validators.dart';

class CategoriesDropDown extends StatefulWidget {
  const CategoriesDropDown({super.key, required this.categoryController});
  final TextEditingController categoryController;
  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  List<String> categories = [
    'ነገረ ማርያም',
    'ነገረ ድኅነት',
    'ምስጢራተ ቤተ ክርስቲያን',
    'ነገረ ድኅነት',
    'ምስጢራተ ቤተ ክርስቲያን',
    'ነገረ ድኅነት',
    'ምስጢራተ ቤተ ክርስቲያን',
    'ነገረ ድኅነት',
    'ምስጢራተ ቤተ ክርስቲያን',
    'ነገረ ድኅነት',
    'ምስጢራተ ቤተ ክርስቲያን',
    'ነገረ ድኅነት',
    'ምስጢራተ ቤተ ክርስቲያን',
    'ነገረ ድኅነት',
    'ምስጢራተ ቤተ ክርስቲያን',
    // Add more categories as needed
  ];

  List<String> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategorySelectorBloc, CategorySelectorState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CategorySelectorInitial) {
          return Column(
            children: [
              // Display selected categories
              Wrap(
                spacing: 8.0,
                children: [
                  ...selectedCategories.map((category) {
                    return Chip(
                      side: const BorderSide(color: primaryColor),
                      label: Text(category,style: Theme.of(context).textTheme.bodySmall),
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
              SizedBox(height: 8.0),
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
                          suffixIcon: Icon(Icons.arrow_drop_down_circle_sharp,
                              color: secondaryColor),
                          filled: true,
                          fillColor: textFieldColor,
                          hintText: 'Select a category',
                          hintStyle: Theme.of(context).textTheme.labelSmall,
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
                        return ListTile(
                          title: Text(suggestion,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w300)),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          if (!selectedCategories.contains(suggestion)) {
                            selectedCategories.add(suggestion);
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
        }
        return const SizedBox();
      },
    );
  }
}
