import 'package:flutter/material.dart';

class SomethingWrong extends StatelessWidget {
  final String text;

  const SomethingWrong({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              text,
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
                color: Colors.green,
              ),
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
