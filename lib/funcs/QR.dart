import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';

import '../pages/about.dart';
import '../pages/not_found.dart';

Future<String> scanBarcodeNormal() async {
  String barcodeScanRes;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.BARCODE);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
    print('Failed to get platform version.');
  }
  return barcodeScanRes;
}

void toFindedPage(String barcodeScanRes, BuildContext context) {
  if (barcodeScanRes == '-1') {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotFound()));
  } else {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => About(barcodeScanRes)));
  }
}
