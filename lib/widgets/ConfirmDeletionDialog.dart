import 'package:flutter/material.dart';

class ConfirmDeletionDialog extends StatelessWidget {
  final Function deleteDebt;
  const ConfirmDeletionDialog(this.deleteDebt);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Willst du diesen Eintrag wirklich löschen?',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Arial'
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            onPressed: deleteDebt,
            color: Colors.amber[700],
            child: Text(
              'Ja',
              style: TextStyle(
                color: Colors.black
              )
            )
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.amber[700],
            child: Text(
              'Nein',
              style: TextStyle(
                color: Colors.black
              )
            )
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}


