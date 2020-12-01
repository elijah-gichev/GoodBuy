import 'package:flutter/material.dart';
import 'about.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //To switch the screen to home after 3 seconds
    //in the future will be used to wait for loading
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
      //print('Произошла задержка!!!');
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_right,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
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
