import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbrtesttask/models/country.dart';

import '../../repositories/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseRepo repository;
  DatabaseBloc(this.repository) : super(DatabaseState()) {
    on<InitialFetchEvent>((event, emit) async {
      final countries = await repository.getCountries();
      emit(
        state.copyWith(countries: countries, state: SearchState.initial),
      );
    });
    on<SearchCountry>(
      (event, emit) async {
        await _getSearchedTransactions(
            emit: emit, searchedValue: event.searchValue!.toUpperCase());
      },
    );
  }

  Future<void> _getSearchedTransactions({
    required Emitter emit,
    required String searchedValue,
  }) async {
    final searchedCountries =
        await repository.getSearchedCountry(searchedValue);
    emit(state.copyWith(
      searchedCountries: searchedCountries,
      state: SearchState.search,
    ));
  }
}
