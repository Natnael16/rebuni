import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecase/search_tables_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchUseCase searchUseCase;
  SearchBloc(this.searchUseCase) : super(SearchInitial()) {
    on<Search>(_onSearch);
  }
  _onSearch(Search event, Emitter emit) async {
    emit(SearchLoading());
    var response = await searchUseCase(SearchParams(categories: event.categories, sortBy: event.sortBy, term: event.term, table : event.table));
    response.fold(
        (Failure failure) => emit(SearchFailure(failure.errorMessage)),
        (List<dynamic> success) => emit(SearchSuccess(success)));
  }
}
