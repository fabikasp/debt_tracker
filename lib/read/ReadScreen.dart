import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadScreen extends StatelessWidget {
  final Map data;
  ReadScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Column(
            children: <Widget>[
              SizedBox(height: 35),
              Text(
                'DebtTracker',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Arial'
                )
              )
            ],
          ),
          backgroundColor: Colors.amber[700]
        )
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Typ:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 5),
            Text(
              data['type'] == 'debt' ? 'Schuld' : 'Forderung',
              style: TextStyle(
                color: data['type'] == 'debt' ? Colors.red : Colors.green,
                fontSize: 20,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 30),
            Text(
              'Person:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 5),
            Text(
              data['person'],
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
              ),
              overflow: TextOverflow.clip,
            ),
            SizedBox(height: 30),
            Text(
              'Grund:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Text(
                data['reason'],
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 20,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Betrag:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 5),
            Text(
              data['amount'].toStringAsFixed(2) + ' €',
              style: TextStyle(
                color: data['type'] == 'debt' ? Colors.red : Colors.green,
                fontSize: 20,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold
              ),
              overflow: TextOverflow.clip,
            ),
            SizedBox(height: 30),
            Container(
              width: 100,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                disabledColor: Colors.black12,
                color: Colors.black12,
                icon: Icon(
                  Icons.beenhere,
                  size: 50,
                  color: Colors.amber[700]
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
