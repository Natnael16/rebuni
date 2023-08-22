part of 'category_selector_bloc.dart';

class CategorySelectorInitial extends Equatable {
  final List<String> categories;

  const CategorySelectorInitial([this.categories = const []]);

  @override
  List<Object> get props => [categories];
}
