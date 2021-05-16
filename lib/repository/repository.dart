import '../models/full_product_info.dart';
import '../funcs/pref_helper/save_product_local.dart';
import '../models/fetched_link.dart';

import '../data_providers/firebase_provider.dart';
import '../data_providers/otzovik_reviews_provider.dart';
import '../data_providers/link_provider.dart';

class Repository {
  final LinkProvider linkProvider = LinkProvider();

  final ProductReviewsProvider productReviewsProvider =
      ProductReviewsProvider();

  final FirebaseReviewsProvider firebaseReviewsProvider =
      FirebaseReviewsProvider();

  Future<FullProductInfo> getAllDataThatMeetsRequirements(String qr) async {
    FullProductInfo reviewsInfo;
    try {
      final FetchedLink linkInfo =
          await linkProvider.readData(qr); //получили с бд ссылку на товары

      reviewsInfo = await productReviewsProvider
          .readData(linkInfo.link); // настоящие данные

      // reviewsInfo = await productReviewsProvider
      //     .emulateReadData(qr); //данные для тестирования

      reviewsInfo.reviews.addAll(await firebaseReviewsProvider
          .readData(qr)); //добавление отзывов из фаербейс

    } on LinkNotFoundException {
      reviewsInfo = FullProductInfo(
          title: "Товар",
          generalRating: 0,
          countRating: 0,
          reviews: []); //если товар не найден, тогда пусто

      reviewsInfo.reviews.addAll(await firebaseReviewsProvider.readData(qr));
    } catch (ec) {
      print("Exception in productReviewsProvider");
    } finally {
      if (reviewsInfo.reviews.isNotEmpty) {
        reviewsInfo.countRating = reviewsInfo.reviews.length;
        reviewsInfo.generalRating = reviewsInfo.reviews
                .map((review) => review.rating)
                .reduce((value, element) => value + element) /
            reviewsInfo.reviews.length;
      }

      saveProductLocal(reviewsInfo.title, reviewsInfo.generalRating,
          "reviewsInfo.urlProductImg", reviewsInfo.countRating, qr);
    }

    if (reviewsInfo.reviews.isEmpty) {
      throw NotFoundException();
    }

    return reviewsInfo;
  }
}

class NotFoundException implements Exception {
  String errMsg() => 'nothing not found';
}
