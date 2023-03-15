// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'database_bloc.dart';

abstract class DatabaseEvent {}

class InitialFetchEvent extends DatabaseEvent {}

class SearchCountry extends DatabaseEvent {
  final String? searchValue;
  SearchCountry({
    required this.searchValue,
  });
}
