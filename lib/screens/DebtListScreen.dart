import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/widgets/SingleDebt.dart';
import 'package:debttracker/widgets/HeadlineText.dart';
import 'package:debttracker/database/Database.dart';
import 'package:debttracker/screens/CreateScreen.dart';
import 'package:debttracker/widgets/ConfirmDeletionDialog.dart';

class DebtListScreen extends StatefulWidget {
  @override
  _DebtListScreenState createState() => _DebtListScreenState();
}

class _DebtListScreenState extends State<DebtListScreen> {
  FirebaseUser user;
  Database database;
  int maxID = 0;

  void setDebt(String type, String person, double amount, String reason) {
    database.setDebt(maxID + 1, type, person, amount, reason);
  }

  void updateDebt(int id, String type, String person, double amount, String reason) {
    database.setDebt(id, type, person, amount, reason);
  }

  Future<void> connectToFirebase() async {
    final FirebaseAuth authenticate = FirebaseAuth.instance;
    AuthResult result = await authenticate.signInAnonymously();
    user = result.user;

    database = Database(user.uid);
  }

  StreamBuilder<DocumentSnapshot> getTotal(String type) {
    return StreamBuilder<DocumentSnapshot>(
        stream: database.getDebts(),
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

  void deleteDebt(String key, context) {
    database.deleteDebt(key);
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
                            return getTotal('claim');
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
                            return getTotal('debt');
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator()
                        );
                      } else {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: database.getDebts(),
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

                              if (items != null) {
                                for (var singleKey in items.keys) {
                                  if (int.parse(singleKey) > maxID) {
                                    maxID = int.parse(singleKey);
                                  }
                                }
                              } else {
                                maxID = 0;
                              }

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
