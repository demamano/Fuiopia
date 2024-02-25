import 'package:fuiopia/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class Searching extends SearchState {}

///
class SuggestionLoaded extends SearchState {
  final List<String> recentKeywords;
  final List<String> hotKeywords;

  const SuggestionLoaded({required this.recentKeywords, required this.hotKeywords});

  @override
  List<Object> get props => [recentKeywords, hotKeywords];
}

///
class ResultsLoaded extends SearchState {
  final List<Product> results;

  const ResultsLoaded(this.results);

  @override
  List<Object> get props => [results];
}

///
class SearchFailure extends SearchState {
  final String error;

  const SearchFailure(this.error);

  @override
  List<Object> get props => [error];
}
