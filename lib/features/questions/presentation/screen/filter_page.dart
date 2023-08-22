import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rebuni/features/questions/presentation/bloc/categroy_selector_bloc/category_selector_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/shared_widgets/custom_loading_widget.dart';
import '../../../../core/utils/categories.dart';
import '../../../../core/utils/colors.dart';

import '../../../../core/utils/images.dart';
import '../../../authentication/presentation/widgets/custom_textfield.dart';
import '../bloc/search_bloc/search_bloc.dart';
import '../widget/categories_drop_down.dart';
import '../../../../core/shared_widgets/custom_round_button.dart';
import '../widget/top_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FilterPage extends StatefulWidget {
  final TextEditingController searchController;
  final TextEditingController searchForController;
  final TextEditingController sortByController;

  const FilterPage(
      {super.key,
      required this.searchController,
      required this.searchForController,
      required this.sortByController});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _formKey = GlobalKey<FormState>();

  final _categoryController = TextEditingController();

  CategorySelectorBloc? _categorySelectorBloc;
  SearchBloc? _searchBloc;

  late String sortBySelectedValue;
  late String searchForSelectedValue;

  @override
  void initState() {
    _categorySelectorBloc = BlocProvider.of<CategorySelectorBloc>(context);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    sortBySelectedValue = widget.sortByController.text;
    searchForSelectedValue = widget.searchForController.text;

    super.initState();
  }

  @override
  dispose() {
    _categoryController.dispose();
    _categorySelectorBloc?.add(AddCategoriesEvent(const []));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleBottomSheet(
        bottomSheetColor: black.withOpacity(0),
        initHeight: 0.91,
        maxHeight: 0.93,
        minHeight: 0.4,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: white),
        bodyBuilder: (context, index) {
          return SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3.h),
                          Align(
                              alignment: Alignment.center,
                              child: CustomTextFieldQuestions(
                                  autofocus: true,
                                  color: textFieldColor.withOpacity(0.8),
                                  width:
                                      MediaQuery.of(context).size.width - 7.w,
                                  borderRadius: 4,
                                  icon: SvgPicture.asset(textFeildSearchIcon),
                                  validator: (value) => null,
                                  textEditingController:
                                      widget.searchController,
                                  hintText: "Enter a keyword")),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text("Search For:",
                              style: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(height: 1.h),
                          dropDownPackage(searchFor, "Search For"),
                          SizedBox(height: 2.h),
                          Text("Sort By:",
                              style: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(height: 1.h),
                          dropDownPackage(sortBy, "Sort By"),
                          SizedBox(height: 1.h),
                          searchForSelectedValue == "Questions"
                              ? Text("Select Categories:",
                                  style: Theme.of(context).textTheme.bodyLarge)
                              : const SizedBox(),
                          SizedBox(height: 1.h),
                          searchForSelectedValue == "Questions"
                              ? CategoriesDropDown(
                                  categoryController: _categoryController)
                              : const SizedBox(),
                          SizedBox(height: 3.h),
                          Center(
                            child: BlocConsumer<SearchBloc, SearchState>(
                              listener: (context, state) {
                                if (state is SearchSuccess) {
                                  showTopSnackBar(
                                      context,
                                      const TopSnackBar(
                                          message: "Search Filters applied",
                                          error: false));

                                  context.pop();
                                } else if (state is SearchFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Text(
                                            "Failed Please Try Again!",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: white),
                                          ),
                                          const Spacer(),
                                          const Icon(Icons.cancel_outlined,
                                              color: white)
                                        ],
                                      ),
                                      elevation: 5,
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is SearchLoading) {
                                  return const UniqueProgressIndicator();
                                }
                                return CustomRoundButton(
                                    buttonText: 'Apply',
                                    onPressed: onApplyPressed,
                                    borderRadius: 20);
                              },
                            ),
                          )
                        ]),
                  ),
                ),
              );
            },
          );
        });
  }

  Widget dropDownPackage(List<String> items, String text) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.sort_rounded,
              size: 20,
              color: primaryColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: blackTextColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value:
            text == "Search For" ? searchForSelectedValue : sortBySelectedValue,
        onChanged: (String? value) {
          setState(() {
            if (text == "Search For") {
              searchForSelectedValue = value ?? "Questions";
              widget.searchForController.text = value ?? "Questions";
            } else {
              sortBySelectedValue = value ?? "Upvotes";
              widget.sortByController.text = value ?? "Upvotes";
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width - 8.w,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: textFieldColor,
          ),
          elevation: 0,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: containerBackgroundColor,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  onApplyPressed() {
    CategorySelectorInitial categoryState = _categorySelectorBloc!.state;

    _searchBloc!.add(Search(
        categories: categoryState.categories.isNotEmpty
            ? categoryState.categories
            : categories,
        sortBy: sortBySelectedValue == "Date"
            ? "created_at"
            : sortBySelectedValue.toLowerCase(),
        table: searchForSelectedValue == "Comments"
            ? "discussions"
            : searchForSelectedValue == "Replies"
                ? "replys"
                : searchForSelectedValue.toLowerCase(),
        term: widget.searchController.text));
  }
}
