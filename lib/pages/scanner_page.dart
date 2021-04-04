import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String qr = "just data";

  int _selectedIndex = 0;
  void _selectedTab(int index) {
    setState() {
      _selectedIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(
        onTabSelected: _selectedTab,
        items: [
          CustomAppBarItem(icon: Icons.history),
          CustomAppBarItem(icon: Icons.favorite),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/about', arguments: qr);
        },
        child: Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.green,
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          //height: 600.0,
          child: QrCamera(
            onError: (context, error) => Text(
              //error.toString(),
              'Вы отклонили доступ к камере. Перезагрузите приложение!',
              style: TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) {
              //одна из самых важных частей
              //срабатывает, когда сосканирован код
              setState(() {
                //Navigator.of(context).pushNamed('/about', arguments: code);

                qr = code;
                print(code);
              });
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    qr,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 1, color: Colors.green[100]),
                    ),
                    padding: EdgeInsets.only(top: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
