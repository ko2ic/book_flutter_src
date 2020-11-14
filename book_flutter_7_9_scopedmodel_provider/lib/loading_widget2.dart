import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loading_value2.dart';

class LoadingWidget2_2 extends StatelessWidget {
  const LoadingWidget2_2();

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<LoadingValue2>(context);
    return (logic.value)
        ? const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0x44000000),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox.shrink();
  }
}

// CounterValueでChangeNotifierを使った場合は以下
// @override
// Widget build(BuildContext context) {
//   var logic = Provider.of<LoadingValue3>(context);
//   return (logic.isLoading)
//       ? const DecoratedBox(
//           decoration: BoxDecoration(
//             color: Color(0x44000000),
//           ),
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         )
//       : const SizedBox.shrink();
// }
