// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'database_bloc.dart';

enum SearchState {
  initial,
  search,
}

class DatabaseState extends Equatable {
  final SearchState state;
  List<Country> countries = [];
  List<Country> searchedCountries = [];

  DatabaseState({
    this.countries = const <Country>[],
    this.searchedCountries = const <Country>[],
    this.state = SearchState.initial,
  });

  DatabaseState copyWith({
    SearchState? state,
    List<Country>? countries,
    List<Country>? searchedCountries,
  }) {
    return DatabaseState(
      state: state ?? this.state,
      countries: countries ?? this.countries,
      searchedCountries: searchedCountries ?? this.searchedCountries,
    );
  }

  @override
  List<Object?> get props => [
        countries,
        searchedCountries,
        state,
      ];
}
