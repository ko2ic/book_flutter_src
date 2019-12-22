import 'dart:async';

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({Key key}) : super(key: key);

  static const String routeName = '/material/text-form-field';

  @override
  FormsPageState createState() => FormsPageState();
}

class PersonData {
  String name = '';
}

class FormsPageState extends State<FormsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _formWasEdited = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersonData person = PersonData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onWillPop: _warnUserAboutInvalidData,
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 24.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              onSaved: (String value) {
                person.name = value;
              },
              validator: _validateName,
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tell us about yourself (e.g., write down what you do or what hobbies you have)',
                helperText: 'Keep it short, this is just a demo.',
                labelText: 'Life story',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Salary',
                prefixText: '\$',
                suffixText: 'USD',
              ),
              maxLines: 1,
              validator: _validateSalary,
            ),
            const SizedBox(height: 24.0),
            buildCheckbox(),
            const SizedBox(height: 24.0),
            buildRadio(),
            const SizedBox(height: 24.0),
            buildSwitch(),
            const SizedBox(height: 24.0),
            Center(
              child: RaisedButton(
                child: const Text('SUBMIT'),
                onPressed: _handleSubmitted,
              ),
            ),
            const SizedBox(height: 24.0),
            Text('* indicates required field', style: Theme.of(context).textTheme.caption),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(value)));
  }

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${person.name}');
    }
  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return 'Name is required.';
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) return 'Please enter only alphabetical characters.';
    return null;
  }

  String _validateSalary(String value) {
    if (value.isEmpty) return 'Salary is required.';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('This form has errors'),
              content: const Text('Really leave this form?'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC;
  int radioValue = 0;
  bool switchValue = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  Widget buildCheckbox() {
    return Align(
        alignment: const Alignment(0.0, -0.2),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Checkbox(
                value: checkboxValueA,
                onChanged: (bool value) {
                  setState(() {
                    checkboxValueA = value;
                  });
                },
              ),
              Checkbox(
                value: checkboxValueB,
                onChanged: (bool value) {
                  setState(() {
                    checkboxValueB = value;
                  });
                },
              ),
              Checkbox(
                value: checkboxValueC,
                tristate: true,
                onChanged: (bool value) {
                  setState(() {
                    checkboxValueC = value;
                  });
                },
              ),
            ],
          ),
          Row(mainAxisSize: MainAxisSize.min, children: const <Widget>[
            // Disabled checkboxes
            Checkbox(value: true, onChanged: null),
            Checkbox(value: false, onChanged: null),
            Checkbox(value: null, tristate: true, onChanged: null),
          ])
        ]));
  }

  Widget buildRadio() {
    return Align(
        alignment: const Alignment(0.0, -0.2),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Radio<int>(value: 0, groupValue: radioValue, onChanged: handleRadioValueChanged),
            Radio<int>(value: 1, groupValue: radioValue, onChanged: handleRadioValueChanged),
            Radio<int>(value: 2, groupValue: radioValue, onChanged: handleRadioValueChanged)
          ]),
          // Disabled radio buttons
          Row(mainAxisSize: MainAxisSize.min, children: const <Widget>[
            Radio<int>(value: 0, groupValue: 0, onChanged: null),
            Radio<int>(value: 1, groupValue: 0, onChanged: null),
            Radio<int>(value: 2, groupValue: 0, onChanged: null)
          ])
        ]));
  }

  Widget buildSwitch() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Switch.adaptive(
              value: switchValue,
              onChanged: (bool value) {
                setState(() {
                  switchValue = value;
                });
              }),
          // Disabled switches
          const Switch.adaptive(value: true, onChanged: null),
          const Switch.adaptive(value: false, onChanged: null),
        ],
      ),
    );
  }
}
