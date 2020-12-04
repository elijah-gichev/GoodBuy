import 'package:flutter/material.dart';

import '../funcs/QR.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffF0D6C4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.history,
                size: 35,
              ),
              onPressed: () {
                //Navigator.pop(context);
              },
            ),
            Expanded(
              child: IconButton(
                padding: EdgeInsets.only(right: 10),
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 35,
                ),
                onPressed: () async {
                  String barcodeScanRes = await scanBarcodeNormal();
                  toFindedPage(barcodeScanRes, context);
                  // setState(() {
                  //   _barcodeScanRes = barcodeScanRes;
                  // });
                },
              ),
            ),
            SizedBox(
              width: 35,
              height: 35,
            )
          ],
        ),
      ),
    );
  }
}
