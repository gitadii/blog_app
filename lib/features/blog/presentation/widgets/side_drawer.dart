import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              title: Text('Logout.'),
              trailing: Icon(Icons.logout_rounded),
            )
          ],
        ),
      ),
    );
  }
}

// Drawer showSideDrawer () {
//   return const Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             ListTile(
//               title: Text('Logout.'),
//               trailing: Icon(Icons.logout_rounded),
//             )
//           ],
//         ),
//       ),
//     );
// }
