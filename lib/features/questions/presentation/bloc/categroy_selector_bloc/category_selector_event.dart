part of 'category_selector_bloc.dart';

abstract class CategorySelectorEvent extends Equatable {
  const CategorySelectorEvent();

  @override
  List<Object> get props => [];
}

class AddCategoriesEvent extends CategorySelectorEvent {
  List<String> categories;

  AddCategoriesEvent(this.categories);

  @override
  List<Object> get props => [categories];
}
