import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';

import '../funcs/pref_helper/set_favourite_flag_local.dart';
import '../bloc/about/about_bloc.dart';

import '../models/full_product_info.dart';

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
        items: [
          CustomAppBarItem(icon: Icons.history),
          CustomAppBarItem(icon: Icons.favorite),
        ],
        selectedIndex: 2,
      ),
      body: BlocBuilder<AboutBloc, AboutState>(
        builder: (context, state) {
          if (state is AboutInitial) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is AboutNextScanNotAllowed) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 9 / 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Следующее сканирование будет доступно в течение 15 секунд!",
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "Через 15с нажмите на кнопку",
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
          }
          if (state is AboutNoIEConnection) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Нет интернет соединения!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      ';(',
                      style: TextStyle(
                        fontSize: 144,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    height: 35,
                  )
                ],
              ),
            );
          }
          if (state is AboutLoadSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.fullProductInfo.reviews.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Card(
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
                                // print("main simestamp: $startTimestamp");
                                // print(getTimestamp());
                                //state.fullProductInfo.

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
                            'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        //пока непонятно, что делать с картинкой, пока их будет 2 в строке
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/cheese.jpg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Expanded(
                              child: Image.asset(
                                'assets/cheese.jpg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            // Image.network(
                            //     "https://i.otzovik.com/objects/b/870000/867684.png",)//нужен лоадер
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return ReviewCard(
                    review: state.fullProductInfo.reviews[index - 1]);
              },
            );
          }
          if (state is AboutLoadFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Что-то пошло не так!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      ';(',
                      style: TextStyle(
                        fontSize: 144,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    height: 35,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  // final double rate;
  // final String title;
  // final String date = '06.01.2019';
  // final String description =
  //     'Прогуливаясь в магазине Лента увидела в подарочном наборе сыр Камамбер. За два вида цена была 219 рублей. Второй сыр шел в подарок. Редко ем сыры в последнее время, в наших совсем разочаровалась. Но рискнула и...';

  final Review review;
  ReviewCard({
    @required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.arrow_drop_down_circle),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              review.text,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
        ],
      ),
    );
  }
}
