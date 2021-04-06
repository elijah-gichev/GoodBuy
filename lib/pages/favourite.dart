import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';
import '../bloc/favourite/favourite_bloc.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteBloc(),
      child: FavouritePageBody(),
    );
  }
}

class FavouritePageBody extends StatefulWidget {
  @override
  _FavouritePageBodyState createState() => _FavouritePageBodyState();
}

class _FavouritePageBodyState extends State<FavouritePageBody> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<FavouriteBloc>().add(FavouriteLoaded());
    });

    return Scaffold(
      body:
          BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
        if (state is FavouriteLoadSuccess) {
          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.savedProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return HistoryCard(
                  state.savedProducts[index].title,
                  state.savedProducts[index].stars,
                  state.savedProducts[index].imgUrl,
                  state.savedProducts[index].reviews,
                  state.savedProducts[index].qr,
                );
              },
            ),
          );
        }
        if (state is FavouriteEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Здесь пока что пусто',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    ';(',
                    style: TextStyle(
                      fontSize: 100,
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
        if (state is FavouriteInitial) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          );
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ScanFAB(),
      bottomNavigationBar: CustomBottomAppBar(
        items: [
          CustomAppBarItem(icon: Icons.history),
          CustomAppBarItem(icon: Icons.favorite),
        ],
        selectedIndex: 1,
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final double stars;
  final String imgUrl;
  final int reviews;
  final String qr; //TODO extended info

  HistoryCard(this.title, this.stars, this.imgUrl, this.reviews, this.qr);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.arrow_drop_down_circle),
            title: Text(title ?? "null"),
            subtitle: Text(
              qr ?? "qr",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Text(
              '$stars/5',
              style: TextStyle(color: stars <= 3 ? Colors.red : Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Оценка состоит из $reviews отзывов",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
