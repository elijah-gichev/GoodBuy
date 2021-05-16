import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_buy/cubit/timer/timer_cubit.dart';
import 'package:good_buy/models/full_product_info.dart';

import '../funcs/pref_helper/set_favourite_flag_local.dart';
import '../bloc/about/about_bloc.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';
import '../widgets/review_card.dart';
import '../widgets/something_wrong.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutBloc(context.read<TimerCubit>()),
      child: AboutBody(),
    );
  }
}

class AboutBody extends StatefulWidget {
  const AboutBody();

  @override
  _AboutBodyState createState() => _AboutBodyState();
}

class _AboutBodyState extends State<AboutBody> {
  bool isFavorite = false;
  String qr;

  @override
  void didChangeDependencies() {
    qr = ModalRoute.of(context).settings.arguments;
    context.read<AboutBloc>().add(AboutStarted(qr: qr));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ScanFAB(),
      bottomNavigationBar: CustomBottomAppBar(
        selectedTab: Tabs.nothing,
      ),
      body: BlocBuilder<AboutBloc, AboutState>(
        builder: (context, state) {
          if (state is AboutInitial) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AboutNotFound) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SomethingWrong(text: 'Данный товар не найден!'),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/add_review',
                          arguments: qr);
                    },
                    label: Text(
                      'Создать отзыв',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 5,
                  ),
                ],
              ),
            );
          } else if (state is AboutNextScanNotAllowed) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 9 / 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Следующее сканирование будет доступно через 15 секунд!",
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "через 15 секунд! нажмите на кнопку",
                          style: TextStyle(color: Colors.green),
                        ),
                        Icon(
                          Icons.qr_code_scanner_outlined,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AboutNoIEConnection) {
            return SomethingWrong(text: 'Нет интернет соединения!');
          } else if (state is AboutLoadSuccess) {
            int goodBuyCount = state.fullProductInfo.reviews
                .where((element) => element.reviewSrc == ReviewSource.goodBuy)
                .length;
            int otzovikCount = state.fullProductInfo.reviews
                .where((element) => element.reviewSrc == ReviewSource.otzovik)
                .length;
            return SafeArea(
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setFavouriteFlagByQr(qr, true);
                                setState(() {
                                  isFavorite = true;
                                });
                              } //добавить в избранное},
                              ),
                          title:
                              Text(state.fullProductInfo.title ?? "null title"),
                          subtitle: Text(
                            'Средняя оценка: ${state.fullProductInfo.generalRating.toStringAsFixed(2)}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          // trailing: Text(
                          //     '${state.fullProductInfo.countRating} отзыва'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'goodBuy отзывов: $goodBuyCount',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                Text(
                                  'otzovik отзывов: $otzovikCount',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: FloatingActionButton.extended(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/add_review',
                                      arguments: qr);
                                },
                                label: Text(
                                  'Создать отзыв',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.white,
                                elevation: 5,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.fullProductInfo.reviews.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(
                          review: state.fullProductInfo.reviews[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            //if (state is AboutLoadFailure) {
            return SomethingWrong(text: 'Что-то пошло не так!');
          }
        },
      ),
    );
  }
}

class ReviewCard2 extends StatelessWidget {
  final Review review;
  ReviewCard2({
    @required this.review,
  });

  @override
  Widget build(BuildContext context) {
    print(review);

    return Card(
      //shadowColor: Theme.of(context).accentColor,
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              review.reviewSrc.toEnumString() + " отзыв",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            // leading: Icon(
            //   Icons.home,
            //   color: Theme.of(context).accentColor,
            // ),
            title: Text(review.author ?? "null"),
            subtitle: Text(
              review.date,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Text(
              '${review.rating}/5',
              style: TextStyle(
                  color: review.rating <= 3 ? Colors.red : Colors.green),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.add_circle_outline,
              color: Colors.green,
              size: 30,
            ),
            title: Text(review.textPlus),
            subtitle: Text(
              'Достоинства',
              style: TextStyle(color: Colors.green.withOpacity(0.6)),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 30,
            ),
            title: Text(review.textMinus),
            subtitle: Text(
              'Недостатки',
              style: TextStyle(color: Colors.red.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              review.text,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
