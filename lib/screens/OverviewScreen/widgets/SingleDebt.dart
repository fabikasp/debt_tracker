import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/screens/UpdateScreen/UpdateScreen.dart';
import 'package:debttracker/screens/ReadScreen//ReadScreen.dart';
import 'package:debttracker/screens/OverviewScreen/widgets/DebtText.dart';
import 'package:debttracker/screens/OverviewScreen/widgets/ClaimText.dart';

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
            title: this.data['type'] == 'debt' ? DebtText(this.data) : ClaimText(this.data),
            trailing: IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                  size: 27,
                ),
                onPressed: () => this.confirmDeletion()
            ),
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateScreen(
                  updateDebt: this.updateDebt,
                  id: this.debtKey,
                  data: this.data
                )),
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadScreen(this.data)),
              );
            },
          );
        },
      )
    );
  }
}
