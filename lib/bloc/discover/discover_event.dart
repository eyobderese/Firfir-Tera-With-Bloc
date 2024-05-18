abstract class DiscoverEvent {}

class SearchQueryChanged extends DiscoverEvent {
  final String query;
  SearchQueryChanged({required this.query});
}

class FilterChanged extends DiscoverEvent {
  final String filter;
  FilterChanged({required this.filter});
}

class QueryCancelled extends DiscoverEvent {
  QueryCancelled();
}

class QuerySummited extends DiscoverEvent {
  QuerySummited();
}
