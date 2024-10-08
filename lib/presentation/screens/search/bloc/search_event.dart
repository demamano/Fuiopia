import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OpenScreen extends SearchEvent {}

class KeywordChanged extends SearchEvent {
  final String keyword;

  const KeywordChanged(this.keyword);

  @override
  List<Object> get props => [keyword];
}
