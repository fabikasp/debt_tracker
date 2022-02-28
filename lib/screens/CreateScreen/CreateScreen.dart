import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  final Function setDebt;
  const CreateScreen({ Key key, this.setDebt }): super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  int radioValue = 0;
  final formKey = GlobalKey<FormState>();
  String person = '';
  String amount = '';
  String reason = '';

  void close() {
    Navigator.pop(context);
  }

  void saveAndClose(String type, String person, String amount, String reason) {
    if (formKey.currentState.validate()) {
      widget.setDebt(type, person, double.parse(amount), reason);
      close();
    }
  }

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }

    return double.tryParse(str) != null;
  }

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
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Text(
                      'Typ:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Arial'
                      )
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                          activeColor: Colors.amber[700],
                        ),
                        Text(
                          'Schuld',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Arial'
                          )
                        ),
                        Radio(
                          value: 1,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          },
                          activeColor: Colors.amber[700],
                        ),
                        Text(
                          'Forderung',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Arial'
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Person',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Arial'
                      )
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10)
                      ),
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Arial'
                      ),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'Bitte Person angeben';
                        }

                        if (input.length > 30) {
                          return 'Nicht mehr als 20 Zeichen verwenden';
                        }

                        return null;
                      },
                      onChanged: (input) {
                        setState(() {
                          person = input;
                        });
                      }
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Grund',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Arial'
                      )
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10)
                      ),
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Arial'
                      ),
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'Bitte Grund angeben';
                        }

                        if (input.length > 100) {
                          return 'Nicht mehr als 100 Zeichen verwenden';
                        }

                        return null;
                      },
                      onChanged: (input) {
                        setState(() {
                          reason = input;
                        });
                      }
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Betrag',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Arial'
                      )
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black
                                )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black
                                )
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.all(10)
                            ),
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Arial'
                            ),
                            validator: (input) {
                              input = input.replaceAll(',', '.');

                              if (input.isEmpty) {
                                return 'Bitte Betrag angeben';
                              }

                              if (!isNumeric(input)) {
                                return 'Betrag muss eine Zahl sein';
                              }

                              if (double.parse(input) == 0) {
                                return 'Betrag ist zu klein';
                              }

                              if (double.parse(input) > 9999999999) {
                                return 'Betrag ist zu groß';
                              }

                              return null;
                            },
                            onChanged: (input) {
                              setState(() {
                                amount = input.replaceAll(',', '.');
                              });
                            }
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          '€',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Arial'
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      height: 45,
                      child: RaisedButton(
                        onPressed: () => saveAndClose(
                          radioValue == 0 ? 'debt' : 'claim',
                          person,
                          amount,
                          reason
                        ),
                        disabledColor: Colors.amber[700],
                        color: Colors.amber[700],
                        textColor: Colors.black,
                        child: Text(
                          'Speichern',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Arial'
                          )
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                      )
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 45,
                      child: RaisedButton(
                        onPressed: close,
                        disabledColor: Colors.black12,
                        color: Colors.black12,
                        textColor: Colors.black,
                        child: Text(
                          'Zurück',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Arial'
                          )
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                      )
                    )
                  ]
                ),
              ),
            ),
          ),
        )
    );
  }
}
