import 'package:flutter/material.dart';
import 'package:good_buy/widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ScanFAB(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'Товар не найден!',
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
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedTab: Tabs.favourite,
      ),
    );
  }
}
