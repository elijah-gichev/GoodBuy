import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String qr;

  @override
  Widget build(BuildContext context) {
    qr = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (context) => AboutBloc(),
      child: AboutBody(qr: qr),
    );
  }
}

class AboutBody extends StatefulWidget {
  final String qr;
  const AboutBody({@required this.qr});

  @override
  _AboutBodyState createState() => _AboutBodyState();
}

class _AboutBodyState extends State<AboutBody> {
  bool isFavorite = false;

  // @override
  void initState() {
    super.initState();
    context.read<AboutBloc>().add(AboutStarted(qr: widget.qr));
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
                                setFavouriteFlagByQr(widget.qr, true);
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '---------',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        //пока непонятно, что делать с картинкой, пока их будет 2 в строке
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Expanded(
                        //       child: Image.asset(
                        //         'assets/cheese.jpg',
                        //         fit: BoxFit.scaleDown,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Image.asset(
                        //         'assets/cheese.jpg',
                        //         fit: BoxFit.scaleDown,
                        //       ),
                        //     ),
                        //     // Image.network(
                        //     //     "https://i.otzovik.com/objects/b/870000/867684.png",)//нужен лоадер
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.fullProductInfo.reviews.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(
                            review: state.fullProductInfo.reviews[index]);
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
