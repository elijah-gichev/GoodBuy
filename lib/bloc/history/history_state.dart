part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoadSuccess extends HistoryState {
  List<Product> savedProducts;

  HistoryLoadSuccess({this.savedProducts});
}

class HistoryEmpty extends HistoryState {}

//class HistoryLoadInProgress extends HistoryState {}
