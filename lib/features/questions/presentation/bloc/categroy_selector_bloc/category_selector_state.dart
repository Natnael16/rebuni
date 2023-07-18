part of 'category_selector_bloc.dart';

abstract class CategorySelectorState extends Equatable {
  const CategorySelectorState();
  
  @override
  List<Object> get props => [];
}

class CategorySelectorInitial extends CategorySelectorState {
  final List<String> categories;

  CategorySelectorInitial([this.categories = const []]);
}