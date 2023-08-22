part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class Search extends SearchEvent {
  final String term;
  final String table;
  final String sortBy;
  final List<String> categories;
  const Search(
      {required this.term,
      required this.table,
      required this.sortBy,
      required this.categories});
  @override
  List<Object> get props => [term, table, sortBy, categories];
}
