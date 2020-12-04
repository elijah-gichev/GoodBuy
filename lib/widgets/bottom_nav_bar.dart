import 'package:flutter/material.dart';
import '../funcs/QR.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}
