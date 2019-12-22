import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonsPage extends StatefulWidget {
  @override
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildRaisedButton(),
          buildFlatButton(),
          buildOutlineButton(),
          buildDropdownButton(),
          buildIconButton(),
          buildActionButton(),
          const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          buildActionButton2(),
          const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          buildCustomButton(),
          const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          buildCustomButton2(),
          const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          buildImageButton(),
          const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
          const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
          const Icon(Icons.error),
          const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
        ],
      ),
    ));
  }

  Widget buildRaisedButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: const Text('RAISED BUTTON', semanticsLabel: 'RAISED BUTTON 1'),
                onPressed: () {
                  // Perform some action
                },
              ),
              const RaisedButton(
                child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 1'),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('RAISED BUTTON', semanticsLabel: 'RAISED BUTTON 2'),
                onPressed: () {
                  // Perform some action
                },
              ),
              RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 2'),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFlatButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 1'),
                onPressed: () {
                  // Perform some action
                },
              ),
              const FlatButton(
                child: Text(
                  'DISABLED',
                  semanticsLabel: 'DISABLED BUTTON 3',
                ),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18.0),
                label: const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 2'),
                onPressed: () {
                  // Perform some action
                },
              ),
              FlatButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18.0),
                label: const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 4'),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOutlineButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton(
                child: const Text('OUTLINE BUTTON', semanticsLabel: 'OUTLINE BUTTON 1'),
                onPressed: () {
                  // Perform some action
                },
              ),
              const OutlineButton(
                child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 5'),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('OUTLINE BUTTON', semanticsLabel: 'OUTLINE BUTTON 2'),
                onPressed: () {
                  // Perform some action
                },
              ),
              OutlineButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 6'),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // https://en.wikipedia.org/wiki/Free_Four
  String dropdown1Value = 'Free';
  String dropdown2Value;
  String dropdown3Value = 'Four';

  Widget buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: const Text('Simple dropdown:'),
            trailing: DropdownButton<String>(
              value: dropdown1Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown1Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: const Text('Dropdown with a hint:'),
            trailing: DropdownButton<String>(
              value: dropdown2Value,
              hint: const Text('Choose'),
              onChanged: (String newValue) {
                setState(() {
                  dropdown2Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: const Text('Scrollable dropdown:'),
            trailing: DropdownButton<String>(
              value: dropdown3Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown3Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four', 'Can', 'I', 'Have', 'A', 'Little', 'Bit', 'More', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  bool iconButtonToggle = false;

  Widget buildIconButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.thumb_up,
              semanticLabel: 'Thumbs up',
            ),
            onPressed: () {
              setState(() => iconButtonToggle = !iconButtonToggle);
            },
            //color: iconButtonToggle ? Theme.of(context).primaryColor : null,
          ),
          const IconButton(
            icon: Icon(
              Icons.thumb_up,
              semanticLabel: 'Thumbs not up',
            ),
            onPressed: null,
          )
        ].map<Widget>((Widget button) => SizedBox(width: 64.0, height: 64.0, child: button)).toList(),
      ),
    );
  }

  Widget buildActionButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Perform some action
        },
        tooltip: 'floating action button',
      ),
    );
  }

  Widget buildActionButton2() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // Perform some action
        },
        tooltip: 'floating action button',
        heroTag: 'buildActionButton2',
      ),
    );
  }

  Widget buildCustomButton() {
    return Center(
      child: Container(
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 100.0,
              height: 100.0,
            ),
          ),
          color: Colors.transparent,
        ),
        color: Colors.orange,
      ),
    );
  }

  Widget buildCustomButton2() {
    return Material(
      type: MaterialType.button,
      color: Colors.orange,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }

  Widget buildImageButton() {
    return SizedBox(
      height: 100,
      width: 200,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            children: <Widget>[
              Image.asset('assets/flutter.png'),
              Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () {}),
              ),
            ],
          );
        },
      ),
    );
  }
}
