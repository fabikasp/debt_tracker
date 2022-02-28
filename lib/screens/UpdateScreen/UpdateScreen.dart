import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final Function updateDebt;
  final String id;
  final Map data;
  const UpdateScreen({ Key key, this.updateDebt, this.id, this.data }): super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  int radioValue = 0;
  final formKey = GlobalKey<FormState>();
  String person = '';
  String amount = '';
  String reason = '';

  void close() {
    Navigator.pop(context);
  }

  void saveAndClose(String id, String type, String person, String amount, String reason) {
    if (this.formKey.currentState.validate()) {
      widget.updateDebt(int.parse(id), type, person, double.parse(amount), reason);
      close();
    }
  }

  bool isNumeric(String str) {
    print(widget.id);
    if (str == null) {
      return false;
    }

    return double.tryParse(str) != null;
  }

  String validatePerson(String person) {
    if (person.isEmpty) {
      return 'Bitte Person angeben';
    }

    if (person.length > 30) {
      return 'Nicht mehr als 20 Zeichen verwenden';
    }

    return null;
  }

  String validateReason(String reason) {
    if (reason.isEmpty) {
      return 'Bitte Grund angeben';
    }

    if (reason.length > 100) {
      return 'Nicht mehr als 100 Zeichen verwenden';
    }

    return null;
  }

  String validateAmount(String amount) {
    amount = amount.replaceAll(',', '.');

    if (amount.isEmpty) {
      return 'Bitte Betrag angeben';
    }

    if (!this.isNumeric(amount)) {
      return 'Betrag muss eine Zahl sein';
    }

    if (double.parse(amount) == 0) {
      return 'Betrag ist zu klein';
    }

    if (double.parse(amount) > 9999999999) {
      return 'Betrag ist zu groß';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    this.radioValue = widget.data['type'] == 'debt' ? 0 : 1;
    this.person = widget.data['person'];
    this.amount = widget.data['amount'].toString();
    this.reason = widget.data['reason'];
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
                key: this.formKey,
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
                          groupValue: this.radioValue,
                          onChanged: (value) {
                            setState(() {
                              this.radioValue = value;
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
                          groupValue: this.radioValue,
                          onChanged: (value) {
                            setState(() {
                              this.radioValue = value;
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
                      initialValue: widget.data['person'],
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
                      validator: (String input) => this.validatePerson(input),
                      onChanged: (input) {
                        setState(() {
                          this.person = input;
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
                      initialValue: widget.data['reason'],
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
                      validator: (String input) => this.validateReason(input),
                      onChanged: (input) {
                        setState(() {
                          this.reason = input;
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
                            initialValue: widget.data['amount'].toString(),
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
                            validator: (input) => this.validateAmount(input),
                            onChanged: (input) {
                              setState(() {
                                this.amount = input.replaceAll(',', '.');
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
                          widget.id,
                          this.radioValue == 0 ? 'debt' : 'claim',
                          this.person,
                          this.amount,
                          this.reason
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
