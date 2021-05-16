part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoadSuccess extends FavouriteState {
  final List<Product> savedProducts;

  FavouriteLoadSuccess({this.savedProducts});
}

class FavouriteEmpty extends FavouriteState {}
