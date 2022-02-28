import 'package:flutter/material.dart';

class DebtText extends StatelessWidget {
  final Map data;

  DebtText(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Du schuldest ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Arial'
          ),
        ),
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
          this.data['amount'].toStringAsFixed(2) + ' €',
          style: TextStyle(
            color: Colors.red,
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
