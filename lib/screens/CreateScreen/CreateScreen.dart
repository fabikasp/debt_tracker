import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/validator/Validator.dart';

class CreateScreen extends StatefulWidget {
  final Function setDebt;

  CreateScreen({ Key key, this.setDebt }): super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final formKey = GlobalKey<FormState>();
  int radioValue = 0;
  String person = '';
  String amount = '';
  String reason = '';

  void close() {
    Navigator.pop(context);
  }

  void saveAndClose(String type, String person, String amount, String reason) {
    if (this.formKey.currentState.validate()) {
      widget.setDebt(type, person, double.parse(amount), reason);

      this.close();
    }
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
                      validator: (String input) => Validator.validatePerson(input),
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
                      validator: (String input) => Validator.validateReason(input),
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
                            validator: (String input) => Validator.validateAmount(input),
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
                        onPressed: () => this.saveAndClose(
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
