import 'package:flutter/material.dart';

class ClaimText extends StatelessWidget {
  final Map data;

  ClaimText(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.data['person'] + ' ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'schuldet dir ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Arial'
          ),
        ),
        Text(
          this.data['amount'].toStringAsFixed(2) + ' €',
          style: TextStyle(
            color: Colors.green,
            fontSize: 18,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}