import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/screens/OverviewScreen/widgets/SingleDebt.dart';
import 'package:debttracker/screens/OverviewScreen/widgets/HeadlineText.dart';
import 'package:debttracker/screens/OverviewScreen/widgets/ConfirmDeletionDialog.dart';
import 'package:debttracker/screens/CreateScreen/CreateScreen.dart';
import 'package:debttracker/database/Database.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  FirebaseUser user;
  Database database;
  int maxID = 0;

  Future<void> connectToFirebase() async {
    final FirebaseAuth authenticate = FirebaseAuth.instance;
    AuthResult result = await authenticate.signInAnonymously();
    this.user = result.user;

    this.database = Database(this.user.uid);
  }

  void setDebt(String type, String person, double amount, String reason) {
    this.database.setDebt(this.maxID + 1, type, person, amount, reason);
  }

  void updateDebt(int id, String type, String person, double amount, String reason) {
    this.database.setDebt(id, type, person, amount, reason);
  }

  void deleteDebt(String key, context) {
    this.database.deleteDebt(key);
    Navigator.pop(context);
  }

  void confirmDeletion(String key, context) {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDeletionDialog(() => deleteDebt(key, context));
        }
    );
  }

  StreamBuilder<DocumentSnapshot> buildHeadlineText(String type) {
    return StreamBuilder<DocumentSnapshot>(
        stream: this.database.getDebts(),
        builder: (
          context,
          AsyncSnapshot<DocumentSnapshot> snapshot
        ) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator()
            );
          } else {
            Map<String, dynamic> items = snapshot.data.data;
            double result = 0.0;

            if (items != null) {
              for (var i in items.keys) {
                if (type == 'debt') {
                  if (items[i]['type'] == 'debt') {
                    result += items[i]['amount'];
                  }
                } else {
                  if (items[i]['type'] == 'claim') {
                    result += items[i]['amount'];
                  }
                }
              }
            }

            return HeadlineText(type, result);
          }
        }
    );
  }

  void setMaxID(Map<String, dynamic> items) {
    if (items != null) {
      for (var singleKey in items.keys) {
        if (int.parse(singleKey) > this.maxID) {
          this.maxID = int.parse(singleKey);
        }
      }
    } else {
      this.maxID = 0;
    }
  }

  buildDebtList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
          child: CircularProgressIndicator()
      );
    } else {
      return StreamBuilder<DocumentSnapshot>(
          stream: this.database.getDebts(),
          builder: (
            context,
            AsyncSnapshot<DocumentSnapshot> snapshot
          ) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator()
              );
            } else {
              Map<String, dynamic> items = snapshot.data.data;
              this.setMaxID(items);

              return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (context, i) {
                  String key = items.keys.elementAt(i);

                  return SingleDebt(
                    key,
                    items[key],
                    () => confirmDeletion(key, context),
                    updateDebt
                  );
                }
              );
            }
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
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
            body: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 5, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FutureBuilder(
                        future: connectToFirebase(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator()
                            );
                          } else {
                            return buildHeadlineText('claim');
                          }
                        }
                      ),
                      SizedBox(height: 5),
                      FutureBuilder(
                        future: connectToFirebase(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator()
                            );
                          } else {
                            return buildHeadlineText('debt');
                          }
                        }
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 3,
                  color: Colors.black
                ),
                Expanded(
                  child: FutureBuilder(
                    future: connectToFirebase(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) => buildDebtList(context, snapshot),
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateScreen(setDebt: setDebt)),
                );
                setState(() {});
              },
              backgroundColor: Colors.amber[700],
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          );
        },
      )
    );
  }
}
