import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';
import '../widgets/something_wrong.dart';
import '../widgets/history_card.dart';

import '../bloc/history/history_bloc.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(),
      child: HistoryPageBody(),
    );
  }
}

class HistoryPageBody extends StatefulWidget {
  @override
  _HistoryPageBodyState createState() => _HistoryPageBodyState();
}

class _HistoryPageBodyState extends State<HistoryPageBody> {
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(HistoryLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
        if (state is HistoryLoadSuccess) {
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
        if (state is HistoryEmpty) {
          return SomethingWrong(text: 'Здесь пока что пусто');
        }
        if (state is HistoryInitial) {
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
        selectedTab: Tabs.history,
      ),
    );
  }
}
