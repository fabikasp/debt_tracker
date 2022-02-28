import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String type;
  final double amount;

  HeadlineText(this.type, this.amount);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          this.type == 'debt' ? 'Gesamtschuld: ' : 'Gesamtforderung: ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold
          )
        ),
        Flexible(
          child: Text(
            this.amount.toStringAsFixed(2) + ' €',
            style: TextStyle(
              color: this.type == 'debt' ? Colors.red : Colors.green,
              fontSize: 20,
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
