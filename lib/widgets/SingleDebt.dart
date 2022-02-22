import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/screens/UpdateScreen.dart';
import 'package:debttracker/widgets/DebtText.dart';
import 'package:debttracker/widgets/ClaimText.dart';
import 'package:debttracker/screens/ReadScreen.dart';

class SingleDebt extends StatelessWidget {
  final String debtKey;
  final Map data;
  final Function confirmDeletion;
  final Function updateDebt;
  SingleDebt(this.debtKey, this.data, this.confirmDeletion, this.updateDebt);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 2, right: 2),
      decoration: BoxDecoration(
        color: Colors.black12
      ),
      child: Builder(
        builder: (context) {
          return ListTile(
            title: data['type'] == 'debt' ? DebtText(data) : ClaimText(data),
            trailing: IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                  size: 27,
                ),
                onPressed: () => confirmDeletion()
            ),
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateScreen(
                  updateDebt: updateDebt,
                  id: debtKey,
                  data: data
                )),
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadScreen(data)),
              );
            },
          );
        },
      )
    );
  }
}
