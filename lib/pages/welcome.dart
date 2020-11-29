import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('assets/logo.png'),
            alignment: Alignment.center,
            //color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              'GoodBuy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'tusovka dev.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
