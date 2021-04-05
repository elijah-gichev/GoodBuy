import 'package:flutter/material.dart';

class ScanFAB extends StatefulWidget {
  @override
  _ScanFABState createState() => _ScanFABState();
}

class _ScanFABState extends State<ScanFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/scanner_page');
      },
      child: Icon(
        Icons.qr_code_scanner_outlined,
        color: Colors.green,
      ),
      elevation: 2.0,
      backgroundColor: Colors.white,
    );
  }
}
