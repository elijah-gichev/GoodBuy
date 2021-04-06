import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';
import '../../funcs/pref_helper/get_products_local.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    final currentState = state;

    if (event is HistoryLoaded) {
      if (currentState is HistoryInitial) {
        final dataStorage = await getProductsLocal() as List;
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
          yield HistoryEmpty();
        } else {
          yield HistoryLoadSuccess(savedProducts: savedProducts);
        }
      }
    }
  }
}
