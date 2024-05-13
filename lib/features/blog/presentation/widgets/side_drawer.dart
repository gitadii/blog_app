import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthLoggedOut) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginPage.route(),
            (route) => false,
          );
          showSnackBar(context, "Successfully logged out!");
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }
        return Drawer(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  title: const Text('Logout.'),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogOut());
                    },
                    icon: const Icon(Icons.logout_outlined),
                  ),
                )
              ],
            ),
          ),
        );
      },
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
