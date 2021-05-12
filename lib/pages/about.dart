import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_buy/cubit/timer/timer_cubit.dart';

import '../funcs/pref_helper/set_favourite_flag_local.dart';
import '../bloc/about/about_bloc.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';
import '../widgets/review_card.dart';
import '../widgets/something_wrong.dart';

import '../models/full_product_info.dart';
import 'dart:math';

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
            return SomethingWrong(text: 'Данный товар не найден!');
          } else if (state is AboutNextScanNotAllowed) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 9 / 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Следующее сканирование будет доступно в течение 20 секунд!",
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "Через 20с нажмите на кнопку",
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
                            'Средняя оценка: ${state.fullProductInfo.generalRating}',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          trailing: Text(
                              '${state.fullProductInfo.countRating} отзыва'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Возможно текст'),
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
