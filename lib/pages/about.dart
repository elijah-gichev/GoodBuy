import 'package:flutter/material.dart';

import 'package:good_buy/funcs/QR.dart';
import '../widgets/bottom_nav_bar.dart';

class About extends StatefulWidget {
  final String barcodeScanRes;
  About(this.barcodeScanRes);

  @override
  _AboutState createState() => _AboutState(barcodeScanRes);
}

class _AboutState extends State<About> {
  String _product_name = 'Princess_Ksu';
  double _cost = 100;

  String _barcodeScanRes;
  _AboutState(this._barcodeScanRes);

  String _about_product1 =
      "Конфеты Milka - это сочетание классического молочного шоколада и яркой карамели с миндалём. Очень вкусно и сладко.";
  String _about_product2 =
      "Конфеты сделаны из шоколада milka и именно это чувствуется первым делом. Сам шоколад очень вкусный и имеет насыщенный молочный вкус."
      "Правда, он немного приторный, но при этом очень вкусный.\n"
      "\nВнутри скорлупы находится тот же шоколадный крем, но красит его карамель, которая находится внутри";

  String _formatBarcodeText(String barcode) {
    int maxLength = 30;
    String res = barcode;
    if (barcode == null) {
      res = 'null';
    }

    if (barcode.length > maxLength) {
      res = barcode.substring(0, maxLength) + '...';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0D6C4),
      body: Center(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffEFEAE3),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6,
                  offset: Offset(0, 5),
                )
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/product_logo.png'),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              _formatBarcodeText(_barcodeScanRes),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(Icons.star),
                                  Icon(Icons.star),
                                  Icon(Icons.star)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Стоимость: $_cost рублей',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      _about_product1,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      _about_product2,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/product_img_1.png'),
                        Image.asset('assets/product_img_2.png'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
