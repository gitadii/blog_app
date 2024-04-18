import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  try {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  } catch (e) {
    print(e.toString());
  }
}
  
// void showSnackBar(BuildContext context, String content) {
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(
//       SnackBar(
//         content: Text(content),
//       ),
//     );
// }