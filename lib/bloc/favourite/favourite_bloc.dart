import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';
import '../../funcs/pref_helper/get_favourite_products_local.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    final currentState = state;

    if (event is FavouriteLoaded) {
      if (currentState is FavouriteInitial) {
        final dataStorage = await getFavouritesProductsLocal() as List;
        final savedProducts = dataStorage.map((element) {
          return Product(
              title: element['title'],
              stars: element['stars'],
              imgUrl: element['img'],
              reviews: element['reviews'],
              qr: element['qr'],
              isFavourite: element['isFavourite']);
        }).toList();

        if (savedProducts.isEmpty) {
          yield FavouriteEmpty();
        } else {
          yield FavouriteLoadSuccess(savedProducts: savedProducts);
        }
      }
    }
  }
}
