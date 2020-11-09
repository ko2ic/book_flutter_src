import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/second',
              arguments: 'messageFromFirst',
            );
          },
          child: const Text('Next Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  Widget build(BuildContext context) {
    var messageFromFirst = ModalRoute.of(context).settings.arguments;
    print(messageFromFirst);
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}

// onGenerateRouteを使う場合

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/': (context) => FirstPage(),
//       },
//       onGenerateRoute: (settings) {
//         if (settings.name == '/second') {
//           var messageFromFirst = settings.arguments;
//           return MaterialPageRoute(
//             builder: (context) {
//               return SecondPage("messageFromFirst");
//             },
//           );
//         }
//         return null;
//       },
//     );
//   }
// }
//
// class FirstPage extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('First Page')),
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             Navigator.pushNamed(
//               context,
//               '/second',
//               arguments: 'messageFromFirst',
//             );
//           },
//           child: const Text('Next Page'),
//         ),
//       ),
//     );
//   }
// }
//
// class SecondPage extends StatelessWidget {
//   final String messageFromFirst;
//
//   SecondPage(this.messageFromFirst);
//
//   Widget build(BuildContext context) {
//     print(messageFromFirst);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Second Page')),
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back'),
//         ),
//       ),
//     );
//   }
// }
