import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
import 'welcome.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String qr = "just data";
  bool camState = true;

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
        items: [
          CustomAppBarItem(icon: Icons.history),
          CustomAppBarItem(icon: Icons.favorite),
        ],
        selectedIndex: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            camState = !camState;
          });

          QrMobileVision.stop();
          if (!camState)
            Navigator.of(context).pushNamed('/about', arguments: qr);
        },
        child: Icon(
          camState
              ? Icons.done_outline_rounded
              : Icons.qr_code_scanner_outlined,
          color: Colors.green,
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: camState
              ? QrCamera(
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
                      qr = code ?? 'not null';
                      print(code);
                    });
                  },
                  notStartedBuilder: (context) {
                    return FirstPage();
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
                            border:
                                Border.all(width: 1, color: Colors.green[100]),
                          ),
                          padding: EdgeInsets.only(top: 50),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text('Для перезагрузки сканера, нажмите на кнопку'),
                        Icon(
                          Icons.qr_code_scanner_outlined,
                          color: Colors.green,
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
