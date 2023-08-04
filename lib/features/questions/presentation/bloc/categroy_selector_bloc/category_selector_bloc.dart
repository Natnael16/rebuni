import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_selector_event.dart';
part 'category_selector_state.dart';

class CategorySelectorBloc extends Bloc<CategorySelectorEvent, CategorySelectorState> {
  CategorySelectorBloc() : super(const CategorySelectorInitial()) {
    on<AddCategoriesEvent>((event, emit) {
      emit(CategorySelectorInitial(event.categories));
    });
  }
}
