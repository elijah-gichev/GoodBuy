import 'package:flutter/material.dart';
import 'package:good_buy/widgets/bottom_nav_bar.dart';
import '../widgets/scan_fab.dart';

//import '../funcs/QR.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ScanFAB(),
      backgroundColor: Color(0xffF0D6C4),
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
        items: [
          CustomAppBarItem(icon: Icons.history),
          CustomAppBarItem(icon: Icons.favorite),
        ],
        selectedIndex: 1,
      ),
    );
  }
}
